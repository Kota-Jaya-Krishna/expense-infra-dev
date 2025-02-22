# NOTE: We are creating the alb for backend servers using module concept #
# This is Public Load balancer #

module "alb" {
  source = "terraform-aws-modules/alb/aws"    # By default it will pick from GITHUB #
  internal = false

  # expense-dev-app-alb#
  name    = "${var.project_name}-${var.environment}-web-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.public_subnet_ids     # A list of subnet IDs to attach to the LB, as this LB is for Private subnets, we need to add private subnets # 
  create_security_group = false 
  security_groups = [local.web_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-web-alb"
    }
  )
} 

resource "aws_lb_listener" "https" {
  load_balancer_arn = module.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.web_alb_certificate_arn

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Frontend WEB ALB</h1> "
      status_code  = "200"
  }
}
}

resource "aws_route53_record" "web_alb" {
  zone_id = var.zone_id
  name    =  "*.${var.domain_name}"   
  type    = "A"


# these are ALB DNS and zone information.here we have used alias block,please try to check manually in GUI, so u can understand #
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = false
  }
}