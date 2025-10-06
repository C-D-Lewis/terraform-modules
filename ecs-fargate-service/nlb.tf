resource "aws_lb" "nlb" {
  count = var.create_nlb ? 1 : 0

  name               = "${var.service_name}-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.security_group.id]
  subnets            = data.aws_subnets.selected.ids
}

resource "aws_lb_target_group" "nlb_target_group" {
  count = var.create_nlb ? 1 : 0

  name        = "${var.service_name}-nlb-tg"
  port        = var.port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.selected.id

  health_check {
    interval            = 30
    port                = var.health_check_port != null ? tostring(var.health_check_port) : "traffic-port"
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  depends_on = [aws_lb.nlb]
}

# Use application port
resource "aws_lb_listener" "server_nlb_listener" {
  count = var.create_nlb ? 1 : 0

  load_balancer_arn = aws_lb.nlb[0].arn
  port              = var.port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group[0].arn
  }
}
