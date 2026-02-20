#############################################
# OUTPUT STRAPI URL
#############################################

output "strapi_url" {
  value = "http://${data.aws_network_interface.ecs_eni.public_ip}:1337"
}