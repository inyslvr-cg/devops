output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.nginx_web.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.nginx_web.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.nginx_web.private_ip
}

output "instance_public_DNS" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.nginx_web.public_dns
}

output "instance_public_key" {
  description = "Public key of app-key-pair"
  value       = tls_private_key.app-key.public_key_openssh
  sensitive   = true
}

output "instance_private_key" {
  description = "Private key of app-key-pair"
  value       =  tls_private_key.app-key.private_key_pem
  sensitive   = true
}