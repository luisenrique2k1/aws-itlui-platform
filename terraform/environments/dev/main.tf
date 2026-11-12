resource "aws_route53_zone" "itlui" {
  name    = "itlui.com"
  comment = "Public DNS hosted zone for ITLUI"

  tags = {
    Name = "itlui-public-zone"
  }
}