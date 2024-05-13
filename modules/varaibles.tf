variable "region" {
}

variable "vpc_cidr" {
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "preferred_number_of_public_subnets" {
  type        = number
  description = "The number of public subnets"

}

variable "preferred_number_of_private_subnets" {
  type        = number
  description = "The number of private subnets"

}

variable "name" {
  type = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "environment" {
  type        = string
  description = "Environment"
}


variable "ami" {
  type        = string
  description = "Ami Id for the launch template"

}

variable "keypair" {
  type        = string
  description = "Key pair for the instances"
}

variable "account_no" {
  type        = number
  description = "Account number of aws aacount"
}

variable "master-username" {
  type        = string
  description = "Database username"
}

variable "master-password" {
  type        = string
  description = "database password"

}