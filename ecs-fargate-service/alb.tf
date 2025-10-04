resource "aws_lb" "alb" {
  name               = "${var.service_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group.id]
  subnets            = data.aws_subnets.selected.ids
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.service_name}-tg"
  port        = var.port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.selected.id

  # TODO: Add health check configuration to module
  health_check {
    interval            = 30
    path                = "/"
    port                = var.health_check_port
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  depends_on = [aws_lb.alb]
}

# Use application port
resource "aws_lb_listener" "server_alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.port
  # TODO: ALB might not work for Minecraft, may need Network LB?
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
