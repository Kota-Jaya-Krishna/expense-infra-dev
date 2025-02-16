data "aws_ami" "openvpn" {
    most_recent      = true
    owners           = ["679593333241"]
    
    filter {
        name   = "name"
        values = ["OpenVPN Access Server Community Image-fe8020db-*"]
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

data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project_name}/${var.environment}/vpn_sg_id"
}


# we will get the public subnet ids in string type, now we need to convert from string type to string list using some functions this is placed in locals(please check locals.tf#
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}
