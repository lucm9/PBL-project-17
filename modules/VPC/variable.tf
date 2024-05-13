variable "region" {
}

variable "vpc_cidr" {
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "preferred_number_of_public_subnets" {
  type        = number
  description = "The number of public subnets"

}

variable "preferred_number_of_private_subnets" {
  type        = number
  description = "The number of private subnets"

}

variable "private_subnets" {
  type        = list(any)
  description = "List of private subnets"

}

variable "public_subnets" {
  type        = list(any)
  description = "List of public subnets"
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

