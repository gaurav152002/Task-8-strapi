#############################################
# VPC MODULE
#############################################

module "vpc" {
  source = "./modules/vpc"
}

#############################################
# SECURITY MODULE
#############################################

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

#############################################
# ECR MODULE
#############################################

module "ecr" {
  source = "./modules/ecr"
}

#############################################
# CLOUDWATCH MODULE
#############################################

module "cloudwatch" {
  source = "./modules/cloudwatch"
  region = var.region
}

#############################################
# ECS MODULE
#############################################

module "ecs" {
  source              = "./modules/ecs"
  region              = var.region
  subnet_ids          = module.vpc.subnet_ids
  security_group_id   = module.security.security_group_id
  ecr_repo_url        = module.ecr.repository_url
  log_group_name      = module.cloudwatch.log_group_name
}

#############################################
# FINAL OUTPUT
#############################################

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}