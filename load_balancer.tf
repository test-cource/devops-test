// zebrah load balancer
resource "aws_lb_listener" "zebrah_listener_https" {
    load_balancer_arn = aws_lb.zebrah_lb.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = aws_acm_certificate.cert.arn
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.zebrah.arn
    }
}

resource "aws_lb_listener" "zebrah_listener_http" {
    load_balancer_arn = aws_lb.zebrah_lb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_lb" "zebrah_lb" {
    name               = "zebrah"
    internal           = false
    load_balancer_type = "application"
    subnets            = [aws_subnet.public.id, aws_subnet.private.id]
    enable_deletion_protection = false
    security_groups    = [aws_security_group.awsvpc_sg.id]
    tags = {
        Environment = "production"
    }
}

resource "aws_lb_target_group" "zebrah" {
    name     = "zebrah"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.zebrah-vpc.id
    depends_on = [aws_lb.zebrah_lb]
    deregistration_delay = 0
    health_check {
        path = "/"
        matcher = "200-310"
        interval = 300
    }
    tags = {
        Name = "zebrah_target_lb"
        Environment = var.ENV_NAME
    }
}
