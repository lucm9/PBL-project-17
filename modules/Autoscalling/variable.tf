variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "public_subnets" {
  type = list()
}

variable "private_subnets" {
  type = list()
}

variable "desired_capacity" {
  type = number
}

variable "wordpress-alb-tgt" {
  type        = string
  description = "wordpress target group"
}

variable "nginx-alb-tgt" {
  type        = string
  description = "nginx target group"
}

variable "ami-web" {
  type = string
  description = "AMI of the instance"
}

variable "ami-nginx" {
  type = string
  description = "AMI of the instance"
}

variable "ami-bastion" {
  type = string
  description = "AMI of the instance"
}

variable "bastion-sg" {
  type = list()
  description = "Security group for bastion"  
}

variable "nginx-sg" {
  type = list()
  description = "Security group for nginx"  
}

variable "web-sg" {
  type = list()
  description = "Security group for web"  
}

variable "keypair" {
  type = string
  description = "Keypair"
}

variable "instance_profile" {
  type = string
  description = "Role being attached to instance"
}


variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}