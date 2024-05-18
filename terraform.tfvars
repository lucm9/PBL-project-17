region = "us-east-2"

ami = "ami-09040d770ffe2224f"

vpc_cidr = "10.10.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

account_no = 533267047415

keypair = "PC"

db-username = "luc"

db-password = "1234567890"

tags = {
  Enviroment      = "production"
  Owner-Email     = "kodzovimally@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "533267047415"
}

versioning_status = "Enabled"

bucket_name = "lucteststate18"

name = "LEE"
db_name = "lucdb"