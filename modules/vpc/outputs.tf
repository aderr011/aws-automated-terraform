output "cc_vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.ad_vpc.id
}

output "cc_public_subnets" {
  description = "Will be used by Web Server Module to set subnet_ids"
  value = [
    aws_subnet.ad_subnet_1,
    aws_subnet.ad_subnet_2
  ]
}

output "cc_private_subnets" {
  description = "Will be used by RDS Module to set subnet_ids"
  value = [
    aws_subnet.ad_private_subnet_1,
    aws_subnet.ad_private_subnet_2
  ]
}