resource "aws_route53_record" "server_record" {
  zone_id = var.route53_zone_id
  name    = "${var.service_name}-api.${var.route53_domain_name}"
  type    = "A"

  alias {
    name                   = var.create_alb ? aws_lb.alb[0].dns_name : aws_lb.nlb[0].dns_name
    zone_id                = var.create_alb ? aws_lb.alb[0].zone_id : aws_lb.nlb[0].zone_id
    evaluate_target_health = false
  }
}
