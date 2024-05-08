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

# Create public subnets
resource "aws_subnet" "public" {
  #count                   = 2
  count                   = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets # if var.preferred_number_of_public_subnets == null then use length(data.aws_availability_zones.available.names) if not empty use var.preferred
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index) #terraform console > cidrsubnet("172.16.0.0/16", 4, 0)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index] # names=local name 

  tags = merge(
    var.tags,
    {
      Name = format("%s-PublicSubnet-%s", var.name, count.index)
    },
  )

}

# Create private subnet 
resource "aws_subnet" "private" {
  count      = var.preferred_number_of_private_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 2) #terraform console > cidrsubnet("172.16.0.0/16", 4, 0)
  # map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index % 2) # Limit cycling to two availability zones

  tags = merge(
    var.tags,
    {
      Name = format("%s-PrivateSubnet-%s", var.name, count.index)
    },
  )
}

