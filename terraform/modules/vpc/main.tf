#############################################
# USE SPECIFIC VPC
#############################################

data "aws_vpc" "existing" {
  id = "vpc-02394aac3f6ed622b"
}

#############################################
# USE SPECIFIC PUBLIC SUBNET
#############################################

data "aws_subnet" "public" {
  id = "subnet-0fbd6ace1bb63c1c1"
}