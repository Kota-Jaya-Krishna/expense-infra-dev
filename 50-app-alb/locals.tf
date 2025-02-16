locals {
    # StringList to List #  AWS side StringList and Terraform side List #
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    app_alb_sg_id = data.aws_ssm_parameter.app_alb_sg_id.value
}