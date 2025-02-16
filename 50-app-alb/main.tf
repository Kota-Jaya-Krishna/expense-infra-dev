# NOTE: We are creating the alb for backend servers using module concept #
# This Private Load balancer #

module "alb" {
  source = "terraform-aws-modules/alb/aws"    # By default it will pick from GITHUB #
  internal = true 

  # expense-dev-app-alb#
  name    = "${var.project_name}-${var.environment}-app-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.private_subnet_ids     # A list of subnet IDs to attach to the LB, as this LB is for Private subnets, we need to add private subnets # 
  create_security_group = false 
  security_groups = [local.app_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-app-alb"
    }
  )
} 

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Backend APP ALB</h1> "
      status_code  = "200"
  }
}
}

resource "aws_route53_record" "app_alb" {
  zone_id = var.zone_id
  name    =  "*.app-dev.${var.domain_name}"
  type    = "A"


# these are ALB DNS and zone information.
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}

