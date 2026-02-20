#############################################
# ECS CLUSTER
#############################################

resource "aws_ecs_cluster" "cluster" {
  name = "gaurav-strapi-task8-cluster"
}

#############################################
# ECS TASK DEFINITION
#############################################

resource "aws_ecs_task_definition" "task" {
  family                   = "gaurav-strapi-task8-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = "arn:aws:iam::811738710312:role/ecs_fargate_taskRole"

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "${var.ecr_repo_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "NODE_ENV",          value = "production" },
        { name = "APP_KEYS",          value = "key1,key2,key3,key4" },
        { name = "API_TOKEN_SALT",    value = "randomAPITokenSalt123" },
        { name = "ADMIN_JWT_SECRET",  value = "superSecretAdminJWT123" },
        { name = "JWT_SECRET",        value = "superSecretJWT123" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group_name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

#############################################
# ECS SERVICE
#############################################

resource "aws_ecs_service" "service" {
  name            = "gaurav-strapi-task8-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }

  force_new_deployment = true

  depends_on = [
    aws_ecs_task_definition.task
  ]
}