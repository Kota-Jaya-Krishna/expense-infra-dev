data "aws_ami" "joindevops" {
    most_recent      = true
    owners           = ["973714476881"]
    
    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

#data source are useful to read the existing information#

data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project_name}/${var.environment}/bastion_sg_id"
}


# we will get the public subnet ids in string type, now we need to convert from string type to string list using some functions this is placed in locals(please check locals.tf#
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}
