resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = "/ecs/gaurav-strapi-task8"
  retention_in_days = 7
}

resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "gaurav-strapi-task8-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization"],
            ["AWS/ECS", "MemoryUtilization"],
            ["AWS/ECS", "RunningTaskCount"],
            ["AWS/ECS", "NetworkIn"],
            ["AWS/ECS", "NetworkOut"]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "ECS Metrics"
        }
      }
    ]
  })
}