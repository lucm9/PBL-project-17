# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.tags,
    {
      Name = format("%s-VPC", var.name)
    },
  )
}

# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Calculate the number of subnets to create
locals {
  number_of_public_subnets  = var.preferred_number_of_public_subnets != null ? var.preferred_number_of_public_subnets : length(data.aws_availability_zones.available.names)
  number_of_private_subnets = var.preferred_number_of_private_subnets != null ? var.preferred_number_of_private_subnets : length(data.aws_availability_zones.available.names)
}

# SUBNETS (PUBLIC SUBNET)
resource "aws_subnet" "public" {
  count                   = local.number_of_public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = merge(
    var.tags,
    {
      Name = format("%s-PublicSubnet-%s!", var.name, count.index)
    },
  )
}

# SUBNETS (PRIVATE SUBNET)
resource "aws_subnet" "private" {
  count                   = local.number_of_private_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = merge(
    var.tags,
    {
      Name = format("%s-PrivateSubnet-%s!", var.name, count.index)
    },
  )
}
