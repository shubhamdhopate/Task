   terraform {
     backend "s3" {
       bucket  = "testing-tf-state"
       key     = "jenkins/terraform.tfstate"
       region  = "us-east-2"
       profile = "shubham"
     }
   } 
  

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "testing-tf-state"
    key     = "vpc/terraform.tfstate"
    region  = "us-east-2"
    profile = "shubham"
  }
}

module "ec2-instance" {
  source             = "OT-CLOUD-KIT/ec2-instance/aws"
  version            = "0.0.3"
  count_ec2_instance = var.count_ec2_instance
  ec2_name           = var.ec2_name
  public_ip          = var.public_ip
  tags               = var.tags
  volume_size        = var.volume_size
  volume_type        = var.volume_type
  ami_id             = var.ami_id
  key_name           = var.key_name
  instance_type      = var.instance_type
  security_groups    = data.terraform_remote_state.vpc.outputs.web_sg_id
  subnet             = data.terraform_remote_state.vpc.outputs.private_subnet_ids[0][0]
  encrypted_volume   = var.encrypted_volume
}

