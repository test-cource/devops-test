# =================================== main server =====================================
resource "aws_ecs_cluster" "main_ecs" {
    name            = "${var.ENV_NAME}_main_ecs"
    tags = {
        Name = "main_cluster"
        Environment = var.ENV_NAME
    }
}

resource "aws_ecs_service" "fpm_service" {
    name                               = "${var.ENV_NAME}_fpm_service"
    cluster                            = aws_ecs_cluster.main_ecs.arn
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 0
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "EC2"
    scheduling_strategy                = "REPLICA"
    task_definition                    = aws_ecs_task_definition.fpm_task.arn
    deployment_controller {
        type = "ECS"
    }
}

resource "aws_ecs_task_definition" "fpm_task" {
    family                = "fpm_task"
    container_definitions = <<DEFINITION
[
  {
    "name": "fpm",
    "image": "082006649170.dkr.ecr.${var.region}.amazonaws.com/fpm:${var.tag}",
    "cpu": 2048,
    "memory": 459,
    "essential": true,
    "logConfiguration": {
      "logDriver": "json-file",
      "options": {
        "max-size": "10m",
        "max-file": "3"
      }

    },
    "mountPoints" : [
      {
        "containerPath" : "/var/www/Zebrah/front",
        "sourceVolume"  : "front"
      },
      {
        "containerPath" : "/var/www/Zebrah/engine",
        "sourceVolume"  : "engine"
      }
    ]
  }
]
DEFINITION
    tags = {
        Name = "fpm_task"
        Environment = var.ENV_NAME
    }
    volume {
        name      = "front"
        host_path = "./front/"
    }

    volume {
        name = "engine"
        host_path = "./engine/"
    }
    network_mode = "host"
}

resource "aws_ecs_service" "sockets_service" {
    name                               = "${var.ENV_NAME}_sockets_service"
    cluster                            = aws_ecs_cluster.main_ecs.arn
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 0
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "EC2"
    scheduling_strategy                = "REPLICA"
    task_definition                    = aws_ecs_task_definition.sockets_task.arn
    deployment_controller {
        type = "ECS"
    }
}

resource "aws_ecs_task_definition" "sockets_task" {
    family                = "sockets_task"
    container_definitions = <<DEFINITION
[
  {
    "name": "sockets",
    "image": "082006649170.dkr.ecr.${var.region}.amazonaws.com/sockets:${var.tag}",
    "cpu": 2048,
    "memory": 459,
    "essential": true,
    "logConfiguration": {
      "logDriver": "json-file",
      "options": {
        "max-size": "10m",
        "max-file": "3"
      }
    },
    "environment": [{
      "name": "CASSANDRA_KEYSPACE",
      "value": "minds"},
  {
    "name": "CASSANDRA_SERVERS",
    "value": "10.0.0.202"},
  {
    "name": "JWT_SECRET",
    "value": "97f92d8c8b54b6d6ea51d272fb096a8dd4d223c4dff66bf296c37325bf2396c5b654f28f2ab5f4e899c363d69aefaa44dac60853bef5fb5b8e11a346c6bffe42"},
  {
    "name": "PORT",
    "value": "3030"},
  {
    "name": "REDIS_HOST",
    "value": "127.0.0.1"},
  {
    "name": "REDIS_PORT",
    "value": "6379"}
]
}
]
DEFINITION
    tags = {
        Name = "sockets_task"
        Environment = var.ENV_NAME
    }
    network_mode = "host"
}

// ---------------------------------------- front -------------------------------------------
resource "aws_ecs_service" "front_service" {
    name                               = "${var.ENV_NAME}_front_service"
    cluster                            = aws_ecs_cluster.main_ecs.arn
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 0
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "EC2"
    scheduling_strategy                = "REPLICA"
    task_definition                    = aws_ecs_task_definition.front_task.arn
    deployment_controller {
        type = "ECS"
    }
}
resource "aws_ecs_task_definition" "front_task" {
    family                = "front_task"
    container_definitions = <<DEFINITION
[
  {
    "name": "front",
    "image": "082006649170.dkr.ecr.${var.region}.amazonaws.com/front:${var.tag}",
    "cpu": 2048,
    "memory": 459,
    "essential": true,
    "logConfiguration": {
      "logDriver": "json-file",
      "options": {
        "max-size": "10m",
        "max-file": "3"
      }
    },
    "mountPoints" : [
      {
        "containerPath" : "/var/www/Zebrah/front",
        "sourceVolume"  : "front"
      },
      {
        "containerPath" : "/var/www/Zebrah/engine",
        "sourceVolume"  : "engine"
      }
    ]
  }
]
DEFINITION
    tags = {
        Name = "front_task"
        Environment = var.ENV_NAME
    }
    volume {
        name      = "front"
        host_path = "./front/"
    }

    volume {
        name = "engine"
        host_path = "./engine/"
    }
    network_mode = "host"
}

// ---------------------------------------- nginx -------------------------------------------
resource "aws_ecs_service" "nginx_service" {
    name                               = "${var.ENV_NAME}_nginx_service"
    cluster                            = aws_ecs_cluster.main_ecs.arn
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 0
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "EC2"
    scheduling_strategy                = "REPLICA"
    task_definition                    = aws_ecs_task_definition.nginx_task.arn
    deployment_controller {
        type = "ECS"
    }
}

resource "aws_ecs_task_definition" "nginx_task" {
    family                = "nginx_task"
    container_definitions = <<DEFINITION
[
  {
    "name": "nginx",
    "image": "082006649170.dkr.ecr.${var.region}.amazonaws.com/nginx:${var.tag}",
    "cpu": 2048,
    "memory": 459,
    "essential": true,
    "logConfiguration": {
      "logDriver": "json-file",
      "options": {
        "max-size": "10m",
        "max-file": "3"
      }
    },
    "environment" : [{
      "name": "UPSTREAM_ENDPOINT",
      "value": "127.0.0.1:4200"
    }
],
  "mountPoints" : [
  {
    "containerPath" : "/var/www/Zebrah/front",
    "sourceVolume"  : "front"
  }
]
  }
]
DEFINITION
    tags = {
        Name = "nginx_task"
        Environment = var.ENV_NAME
    }

    volume {
        name      = "front"
        host_path = "./front/"
    }

    network_mode = "host"
}
// ---------------------------------------- runners -------------------------------------------
resource "aws_ecs_service" "runners_service" {
    name                               = "${var.ENV_NAME}_runners_service"
    cluster                            = aws_ecs_cluster.main_ecs.arn
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 0
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "EC2"
    scheduling_strategy                = "REPLICA"
    task_definition                    = aws_ecs_task_definition.runners_task.arn
    deployment_controller {
        type = "ECS"
    }
}

resource "aws_ecs_task_definition" "runners_task" {
    family                = "runners_task"
    container_definitions = <<DEFINITION
[
  {
    "name": "runners",
    "image": "082006649170.dkr.ecr.${var.region}.amazonaws.com/runners:${var.tag}",
    "cpu": 2048,
    "memory": 459,
    "essential": true,
    "mountPoints" : [
      {
        "containerPath" : "/var/www/Zebrah/front",
        "sourceVolume"  : "front"
      },
      {
        "containerPath" : "/var/www/Zebrah/engine",
        "sourceVolume"  : "engine"
      }
    ]
  }
]
DEFINITION
    tags = {
        Name = "runners_task"
        Environment = var.ENV_NAME
    }

    volume {
        name      = "front"
        host_path = "./front/"
    }

    volume {
        name      = "engine"
        host_path = "./engine/"
    }
    network_mode = "host"
}
// ---------------------------------------- installer -------------------------------------------
resource "aws_ecs_service" "installer_service" {
    name                               = "${var.ENV_NAME}_installer_service"
    cluster                            = aws_ecs_cluster.main_ecs.arn
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 0
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "EC2"
    scheduling_strategy                = "REPLICA"
    task_definition                    = aws_ecs_task_definition.installer_task.arn
    deployment_controller {
        type = "ECS"
    }
}

resource "aws_ecs_task_definition" "installer_task" {
    family                = "installer_task"
    container_definitions = <<DEFINITION
[
  {
    "name": "installer",
    "image": "082006649170.dkr.ecr.${var.region}.amazonaws.com/installer:${var.tag}",
    "cpu": 1024,
    "memory": 459,
    "essential": true
  }
]
DEFINITION
    tags = {
        Name = "installer_task"
        Environment = var.ENV_NAME
    }
    network_mode = "host"
}

# =================================== cassandra server =====================================
resource "aws_ecs_cluster" "cassandra_ecs" {
    name            = "${var.ENV_NAME}_cassandra_ecs"
    tags = {
        Name = "cassandra_cluster"
        Environment = var.ENV_NAME
    }
}

resource "aws_ecs_service" "cassandra_service" {
    name                               = "${var.ENV_NAME}_fpm_service"
    cluster                            = aws_ecs_cluster.cassandra_ecs.arn
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 0
    desired_count                      = 1
    enable_ecs_managed_tags            = false
    health_check_grace_period_seconds  = 0
    launch_type                        = "EC2"
    scheduling_strategy                = "REPLICA"
    task_definition                    = aws_ecs_task_definition.cassandra_task.arn
    deployment_controller {
        type = "ECS"
    }
}

resource "aws_ecs_task_definition" "cassandra_task" {
    family                = "cassandra_task"
    container_definitions = <<DEFINITION
[
  {
    "name": "cassandra",
    "image": "082006649170.dkr.ecr.${var.region}.amazonaws.com/cassandra:${var.tag}",
    "cpu": 2048,
    "memory": 459,
    "essential": true,
    "logConfiguration": {
      "logDriver": "json-file",
      "options": {
        "max-size": "10m",
        "max-file": "3"
      }
    },
    "environment": [
      {"name": "CASSANDRA_START_RPC", "value": "true" },
      {"name": "MAX_HEAP_SIZE", "value": "8G" },
      {"name": "HEAP_NEWSIZE", "value": "800M" }
    ],
    "healthCheck": {
      "command": ["CMD","cqlsh -e 'DESC TABLE system.batches' || exit 1"],
      "interval": 15,
      "timeout": 5,
      "retries": 10
    }
  }
]
DEFINITION
    tags = {
        Name = "cassandra_task"
        Environment = var.ENV_NAME
    }
    network_mode = "host"
}
