region = "us-east-2"

vpc_cidr = "10.10.0.0/16"

enable_dns_hostnames = "true"

enable_dns_support = "true"

preferred_number_of_private_subnets = 4

preferred_number_of_public_subnets = 2

name = "Xashy"

environment = "DEV"

ami = "ami-09040d770ffe2224f"

keypair = "PC"

account_no = "533267047415"

master-username = "admin"
master-password = "adminadmin"

tags = {
  Enviroment      = "development"
  Owner-Email     = "mallykodzovi@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "533267047415"
}



