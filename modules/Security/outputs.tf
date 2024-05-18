output "ALB-sg" {
  value = aws_security_group.XA["ext-alb-sg"].id
}


output "IALB-sg" {
  value = aws_security_group.XA["int-alb-sg"].id
}


output "bastion-sg" {
  value = aws_security_group.XA["bastion-sg"].id
}


output "nginx-sg" {
  value = aws_security_group.XA["nginx-sg"].id
}


output "web-sg" {
  value = aws_security_group.XA["webserver-sg"].id
}


output "datalayer-sg" {
  value = aws_security_group.XA["datalayer-sg"].id
}