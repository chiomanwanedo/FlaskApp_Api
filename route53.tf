# Create Route 53 Hosted Zone (if not already created)
resource "aws_route53_zone" "flask_api_zone" {
  name = "sonaka.org"
}

# Create Route 53 Record to Point to ALB
resource "aws_route53_record" "api_dns" {
  zone_id = aws_route53_zone.flask_api_zone.zone_id
  name    = "api.sonaka.org"
  type    = "A"

  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}
