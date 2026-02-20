#############################################
# USE EXISTING VPC
#############################################

data "aws_vpc" "existing" {
  id = "vpc-0295253d470704295"   # <-- replace if you choose another
}

#############################################
# GET SUBNETS FROM THAT VPC
#############################################

data "aws_subnets" "existing" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}