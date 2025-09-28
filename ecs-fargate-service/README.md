# ecs-fargate-service

Terraform module to create resources for a public Fargate ECS service.

Optionally, an EFS volume can be attached

Resources created:

* `aws_cloudwatch_log_group.log_group`
* `aws_ecr_repository.repository`
* `aws_ecs_cluster.cluster`
* `aws_ecs_service.ecs_service`
* `aws_ecs_task_definition.task_definition`
* `aws_iam_role.ecs_task_execution_role`
* `aws_iam_role.ecs_task_role`
* `aws_iam_role_policy.ecs_task_role_policy`
* `aws_iam_role_policy_attachment.ecs-task-execution-role-attachment`
* `aws_lb.alb`
* `aws_lb_listener.server_alb_listener`
* `aws_lb_target_group.target_group`
* `aws_route53_record.server_record`
* `aws_security_group.security_group`


## Variables

* `region` - AWS region
* `service_name` - Name of the ECS service
* `container_cpu` - CPU units for the Fargate task
* `container_memory` - Memory in MiB for the Fargate task
* `port` - Port on which the service will listen
* `vpc_id` - VPC ID where the ECS service will run
* `certificate_arn` - ARN of the SSL certificate for the ALB
* `route53_zone_id` - Route53 zone ID for DNS records
* `route53_domain_name` - Domain name for the Route53 record


## Outputs

* `service_dns` - DNS record for the ECS service
* `ecr_name` - ECR repository name for the ECS service
* `ecr_uri` - ECR repository URI for the ECS service


## Example

```hcl
module "test" {
  source = "../"

  region           = "us-east-1"
  service_name     = "test-service"
  container_cpu    = 512
  container_memory = 1024
  port             = 80
  vpc_id           = "vpc-c3b70bb9"
  certificate_arn  = "arn:aws:acm:us-east-1:617929423658:certificate/a69e6906-579e-431d-9e4c-707877d325b7"
  route53_zone_id  = "Z05682866H59A0KFT8S"
  route53_domain_name = "chrislewis.me.uk"
}
```

## TODO

* Share at existing ALB instead of one per module instance.
* Allow adding permissions for the task role from variable inputs.
