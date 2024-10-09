# resource "aws_instance" "nginx-server" {
#   ami =var.ec2_ami
#   instance_type = var.instance_type
#   subnet_id = aws_subnet.dmz_subnet.id
#   key_name = "tf-key"
# associate_public_ip_address = true
#  user_data = <<-EOF
#               #!/bin/bash
#               sudo apt-get update
#               sudo apt-get install -y nginx
#               sudo systemctl start nginx
#               sudo systemctl enable nginx
#               EOF

#   tags = {
#     Name ="Nginx-server"
#   }
# }
# resource "aws_launch_template" "app-launch-template" {
#   name_prefix = "app-instance"
#   image_id = var.ec2_ami
#   instance_type = var.instance_type
#   key_name = "tf-key"
#   security_group_names = [aws_security_group.app_sg.name]
# }

# resource "aws_autoscaling_group" "app-asg" {
#  vpc_zone_identifier = [aws_subnet.app_subnet.id]
#  desired_capacity = var.desired_count
#  max_size = var.max_size
#  min_size = 1

#  health_check_type = "EC2"
#  health_check_grace_period = 300

#  launch_template {
#    id = aws_launch_template.app-launch-template.id
#    version = "$Latest"
#  }
#  tag {
#    key = "app-lt"
#    value = "ECSASG"
#    propagate_at_launch = true
#  }

# }
# resource "aws_ecr_repository" "app" {
# name = "app-ecr-repo"
  
#  }

# resource "aws_ecs_cluster" "app-cluster" {
#   name ="app-cluster"
# }
# resource "aws_ecs_task_definition" "app" {
#   family = "app-task"
#   network_mode = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#     cpu = "256"
#     memory = "512"
#     container_definitions = jsonencode([
#     {
#       name      = "app"
#       image     = "${aws_ecr_repository.app.repository_url}:latest"
#       cpu       = 256
#       memory    = 512
#       essential = true
#       portMappings = [{
#         containerPort = 80
#         hostPort      = 80
#       }]
#     }
#   ])
# }
# resource "aws_ecs_service" "app-service" {
#   name = "AppService"
#   cluster = aws_ecs_cluster.app-cluster.id
#   task_definition = aws_ecs_task_definition.app.arn
#   desired_count = 1

#   network_configuration {
#     subnets = [aws_subnet.app_subnet.id]
#     security_groups = [aws_security_group.app_sg.id]
#   }
# }
# resource "aws_s3_bucket" "static_site" {
#   bucket = "sdk-app-demo"

  
# }
# resource "aws_s3_bucket_acl" "acl" {
#     bucket = aws_s3_bucket.static_site.id
#   acl = "public-read"
# }


# # Configure the S3 bucket for website hosting
# resource "aws_s3_bucket_website_configuration" "static_site" {
#   bucket = aws_s3_bucket.static_site.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }
# }
# resource "aws_route53_record" "app-dns" {
#   zone_id = aws_route53_zone.app-zone.zone_id
#   name = "www.sejalkhaire.in"
#   type = "A"

# alias {
# 0zone_id = "Z3AQBSTGFYJSTF"
# evaluate_target_health = false 
# }
# }

# resource "aws_route53_zone" "app-zone" {
#   name = "sejalkhaire.in"
# }