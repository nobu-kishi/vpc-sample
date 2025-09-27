#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${local.prefix}-vpc"
  }
}

#--------------------------------------------------------------
# Public subnet
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public" {
  for_each = local.public_subnet_cidrs

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = "${var.region}${each.key}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.prefix}-public-${each.key}"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${local.prefix}-public-rtb"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

#--------------------------------------------------------------
# Private subnet
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "private" {
  for_each = local.private_subnet_cidrs

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = "${var.region}${each.key}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.prefix}-private-${each.key}"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.this.id
#   }
#   tags = {
#     Name = "${local.prefix}-private-rtb"
#   }
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
# resource "aws_route_table_association" "private" {
#   for_each = aws_subnet.private

#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private.id
# }

#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${local.prefix}-igw"
  }
}

#--------------------------------------------------------------
# NAT
#--------------------------------------------------------------

# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# resource "aws_eip" "nat" {
#   domain     = "vpc"
#   depends_on = [aws_internet_gateway.this]
# }

# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
# resource "aws_nat_gateway" "this" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public["a"].id
#   depends_on    = [aws_internet_gateway.this]
# }

#--------------------------------------------------------------
# VPCフローログ
#--------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/vpc-flow-logs/${local.prefix}/${aws_vpc.this.id}"
  retention_in_days = 5
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "${local.prefix}-vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
  name = "${local.prefix}-vpc-flow-logs-inline-policy"
  role = aws_iam_role.vpc_flow_logs_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log
resource "aws_flow_log" "this" {
  log_destination          = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type     = "cloud-watch-logs"
  iam_role_arn             = aws_iam_role.vpc_flow_logs_role.arn
  traffic_type             = "ALL"
  vpc_id                   = aws_vpc.this.id
  max_aggregation_interval = 600

  depends_on = [aws_iam_role_policy.vpc_flow_logs_policy]
}
