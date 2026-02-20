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

  # Using your existing IAM role
  execution_role_arn = "arn:aws:iam::811738710312:role/ecs_fargate_taskRole"

  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = "${var.ecr_repo_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
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

  depends_on = [
    aws_ecs_task_definition.task
  ]
}

#############################################
# GET RUNNING ECS TASK
#############################################

data "aws_ecs_tasks" "running" {
  cluster      = aws_ecs_cluster.cluster.id
  service_name = aws_ecs_service.service.name

  depends_on = [aws_ecs_service.service]
}

#############################################
# GET TASK DETAILS
#############################################

data "aws_ecs_task" "task_details" {
  task_arn = data.aws_ecs_tasks.running.task_arns[0]
  cluster  = aws_ecs_cluster.cluster.id
}

#############################################
# GET NETWORK INTERFACE (ENI)
#############################################

data "aws_network_interface" "ecs_eni" {
  id = data.aws_ecs_task.task_details.attachments[0].details[1].value
}