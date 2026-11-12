output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.itlui.zone_id
}

output "route53_name_servers" {
  description = "AWS nameservers to configure in IONOS"
  value       = aws_route53_zone.itlui.name_servers
}