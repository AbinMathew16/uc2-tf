output "web_server_1_public_ip" {
  value = aws_instance.web_server_1.public_ip
}
output "web_server_1_private_ip" {
  value = aws_instance.web_server_1.private_ip
}
output "web_server_2_public_ip" {
  value = aws_instance.web_server_2.public_ip
}
output "web_server_2_private_ip" {
  value = aws_instance.web_server_2.private_ip
}
output "load_balancer_dns" {
  value = aws_lb.tf_uc2_loadbalancer.dns_name
}
