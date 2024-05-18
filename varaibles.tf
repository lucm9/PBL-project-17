variable "region" {
}

variable "vpc_cidr" {
}

variable "enable_dns_support" {
  
}

variable "enable_dns_hostnames" {
 
}

variable "preferred_number_of_public_subnets" {
  default = 2
}

variable "preferred_number_of_private_subnets" {
  default = 4
}

variable "name" {
  type    = string
 
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "keypair" {
  type = string
}

variable "ami" {
  type    = string
  default = ""
}

variable "account_no" {
  type = number

}

variable "db-username" {
  type        = string
  description = "RDS admin username"
}

variable "db-password" {
  type        = string
  description = "RDS master password"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}


variable "versioning_status" {
  description = "The versioning status for the S3 bucket"
  type        = string
}

variable "db_name" {
  type        = string
  description = "Database name"
}
