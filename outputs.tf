output "alb_dns" {
  description = "Load Balancer URL"
  value       = aws_lb.app_lb.dns_name
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = aws_db_instance.flask_db.endpoint
}

output "api_public_ip" {
  description = "API server public IP"
  value       = aws_instance.api_server.public_ip
}
