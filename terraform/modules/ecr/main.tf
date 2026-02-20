resource "aws_ecr_repository" "strapi" {
  name = "gaurav-strapi-task8-repo"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.strapi.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      selection = {
        tagStatus = "any"
        countType = "imageCountMoreThan"
        countNumber = 5
      }
      action = { type = "expire" }
    }]
  })
}