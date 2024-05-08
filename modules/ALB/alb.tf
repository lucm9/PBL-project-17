# External Application Load Balancer (ALB) for serving external traffic
resource "aws_lb" "ext-alb" {
  name               = "ext-alb"
  internal           = false
  security_groups    = [aws_security_group.ext-alb-sg.id]
  subnets            = [aws_subnet.public[0].id, aws_subnet.public[1].id]
  ip_address_type    = "ipv4"
  load_balancer_type = "application"

  tags = merge(
    var.tags,
    {
      Name = "ACS-ext-alb"
    },
  )
}

# Target Group for routing traffic to nginx reverse proxy
resource "aws_lb_target_group" "nginx-tgt" {
  name        = "nginx-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

# Listener for HTTPS traffic on the ALB, forwarding traffic to the nginx target group
resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_lb.ext-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.initiativesolution.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}

# Internal Application Load Balancer (ALB) for serving internal traffic
resource "aws_lb" "int-alb" {
  name               = "int-alb"
  internal           = true
  security_groups    = [aws_security_group.int-alb-sg.id]
  subnets            = [aws_subnet.private[0].id, aws_subnet.private[1].id]
  ip_address_type    = "ipv4"
  load_balancer_type = "application"

  tags = merge(
    var.tags,
    {
      Name = "ACS-int-alb"
    },
  )
}

# Target Group for routing traffic to WordPress instances
resource "aws_lb_target_group" "wordpress-tgt" {
  name        = "wordpress-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

# Target Group for routing traffic to tooling instances
resource "aws_lb_target_group" "tooling-tgt" {
  name        = "tooling-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

# Listener for HTTPS traffic on the internal ALB, forwarding traffic to the WordPress target group by default
resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.int-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.initiativesolution.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tgt.arn
  }
}

# Listener rule for routing traffic to the tooling target group based on the host header
resource "aws_lb_listener_rule" "tooling-listener" {
  listener_arn = aws_lb_listener.web-listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tooling-tgt.arn
  }

  condition {
    host_header {
      values = ["tooling.initiativesolution.com"]
    }
  }
}

