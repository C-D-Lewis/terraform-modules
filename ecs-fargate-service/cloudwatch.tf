resource "aws_cloudwatch_log_group" "log_group" {
  name = "/aws/ecs/${var.service_name}-logs"
}
