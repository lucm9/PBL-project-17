resource "aws_iam_role" "ec2_role" {
  name = "ec2_instance_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "aws assume role"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "policy" {
  name        = "ec2_instance_policy"
  description = "A test Policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })

  tags = {
    Name        = "aws assume policy"
    Environment = var.environment
  }
}

resource "aws_iam_instance_profile" "ip" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attach"
  roles      = [aws_iam_role.ec2_role.name] # Corrected resource name
  policy_arn = aws_iam_policy.policy.arn
}
