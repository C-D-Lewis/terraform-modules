resource "aws_ecr_repository" "repository" {
  name                 = "${var.service_name}-ecr"
  image_tag_mutability = "MUTABLE"

  force_delete = true
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.service_name}-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name                 = "${var.service_name}-ecs-service"
  cluster              = aws_ecs_cluster.cluster.id
  task_definition      = aws_ecs_task_definition.task_definition.arn
  desired_count        = 1
  launch_type          = "FARGATE"
  force_new_deployment = true

  # Prevent 2/1 during deployment, in future may want the default settings (min 100% for availability)
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 0

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "${var.service_name}-container"
    container_port   = var.port
  }

  network_configuration {
    security_groups  = [aws_security_group.security_group.id]
    subnets          = data.aws_subnets.selected.ids
    assign_public_ip = true
  }

  deployment_controller {
    type = "ECS"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.service_name}-td"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  requires_compatibilities = ["FARGATE"]

  dynamic "volume" {
    for_each = var.create_efs ? [1] : []

    content {
      name = "service-storage"

      efs_volume_configuration {
        file_system_id     = aws_efs_file_system.efs[0].id
        transit_encryption = "ENABLED"
        root_directory     = "/root"

        authorization_config {
          access_point_id = aws_efs_access_point.docker_ap[0].id
        }
      }
    }
  }

  container_definitions = jsonencode([
    {
      name        = "${var.service_name}-container",
      image       = "${aws_ecr_repository.repository.repository_url}:latest",
      cpu         = var.container_cpu,
      memory      = var.container_memory,
      essential   = true,
      environment = [],
      portMappings = [{
        protocol      = "tcp",
        containerPort = var.port,
        hostPort      = var.port
      }, {
        protocol      = "tcp",
        containerPort = var.health_check_port,
        hostPort      = var.health_check_port
      }],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "/aws/ecs/${var.service_name}-logs",
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "ecs"
        }
      },

      mountPoints = var.create_efs ? [
        {
          sourceVolume  = "service-storage",
          containerPath = "/var/data/efs"
        }
      ] : []
    }
  ])
}
