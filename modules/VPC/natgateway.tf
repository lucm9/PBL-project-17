resource "aws_eip" "nat_eip" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.ig]

  tags = merge(
    var.tags,
    {
      Name = format("%s-EIP-%s", var.name, var.environment)
    },
  )
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0) // Assuming you want to associate it with the first public subnet

  tags = merge(
    var.tags,
    {
      Name = format("%s-NAT-%s", var.name, var.environment)
    },
  )
  # Ensure proper ordering by adding an explicit dependency on the Internet Gateway for the VPC
  depends_on = [aws_internet_gateway.ig]
}
