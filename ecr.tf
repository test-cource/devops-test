resource "aws_ecr_repository" "fpm" {
  name                 = "${var.ENV_NAME}-fpm"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "runners" {
  name                 = "${var.ENV_NAME}-runners"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "sockets" {
  name                 = "${var.ENV_NAME}-sockets"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "installer" {
  name                 = "${var.ENV_NAME}-installer"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "fpm" {
  repository = aws_ecr_repository.fpm.name

  policy = file("policies/ecr_lifecycle_policy.json")
}


resource "aws_ecr_lifecycle_policy" "runners" {
  repository = aws_ecr_repository.runners.name

  policy = file("policies/ecr_lifecycle_policy.json")
}

resource "aws_ecr_lifecycle_policy" "sockets" {
  repository = aws_ecr_repository.sockets.name

  policy = file("policies/ecr_lifecycle_policy.json")
}

resource "aws_ecr_lifecycle_policy" "installer" {
  repository = aws_ecr_repository.installer.name

  policy = file("policies/ecr_lifecycle_policy.json")
}
