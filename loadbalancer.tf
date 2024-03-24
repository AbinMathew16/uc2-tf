resource "aws_alb_target_group" "target_group_tf_uc2" {
    vpc_id = aws_vpc.terraform_vpc.id
    target_type = "instance"
    port = 80
    protocol = "HTTP"
    ip_address_type = "ipv4"
    protocol_version = "HTTP1"
    health_check {
      protocol = "HTTP"
      path = "/"
      healthy_threshold = 5
      unhealthy_threshold = 2
      timeout = 5
      interval = 300
      matcher = "200-299"
    }
    tags = {
      Name ="target-group-tf-uc2"
    }

}

resource "aws_alb_target_group_attachment" "tf_uc2_tg_attachment_1" {
    target_group_arn = aws_alb_target_group.target_group_tf_uc2.arn
    target_id        = aws_instance.web_server_1.id
}

resource "aws_alb_target_group_attachment" "tf_uc2_tg_attachment_2" {
    target_group_arn = aws_alb_target_group.target_group_tf_uc2.arn
    target_id        = aws_instance.web_server_2.id
}

resource "aws_lb" "tf_uc2_loadbalancer" {
    name = "tf-uc2-loadbalancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.loadbalancer_sg.id]
    subnets = [aws_subnet.public_subnet_a.id,aws_subnet.public_subnet_b.id]
    enable_deletion_protection = false
    tags = {
      Name = "tf-uc2-loadbalancer"
    }
  
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.tf_uc2_loadbalancer.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.target_group_tf_uc2.arn
    }
}