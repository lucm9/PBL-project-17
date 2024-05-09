variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "master-username" {
  type        = string
  description = "Database username"
}

variable "master-password" {
  type        = string
  description = "database password"

}

variable "db-sg" {
  type = list
  description = "The DB security group"
}

variable "private_subnets" {
  type        = list
  description = "Private subnets fro DB subnets group"
}

variable "db-name" {
    type = string
    description = "Database name"
  
}

variable "multi_az" {
    type = bool
}