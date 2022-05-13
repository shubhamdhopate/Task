data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "management-bucket-code"
    key     = "key/terraform.tfstate"
    region  = "ap-south-1"
    profile = "shubham"
  }
}


data "aws_lb_listener" "listener" {
  arn = "arn:aws:elasticloadbalancing:ap-south-1:253942872677:listener/app/demo-alb/d59e96ea81734074/8bd6a3cac418be87"
} 


module "ha_ec2_alb" {
  source                         = "OT-CLOUD-KIT/ha-ec2-alb/aws"
  version                        = "0.0.2"
  applicaton_name                = var.applicaton_name
  applicaton_port                = var.applicaton_port
  env_name                       = var.env_name
  applicaton_health_check_target = var.applicaton_health_check_target
  vpc_id                         = data.terraform_remote_state.vpc.outputs.vpc_id
  route53_zone_id                = var.route53_zone_id
  route53_name                   = var.route53_name
  alb_dns_cname                  = var.alb_dns_cname
  ttl                            = var.ttl
  listener_arn                   = data.aws_lb_listener.listener.arn
  priority                       = var.priority
  listener_rule_condition        = var.listener_rule_condition
  listener_rule_condition_values = var.listener_rule_condition_values
  ami_id                         = var.ami_id
  instance_type                  = var.instance_type
  instance_key_name              = var.instance_key_name
  security_groups                = data.terraform_remote_state.vpc.outputs.web_sg_id
  volume_size                    = var.volume_size
  #instance_availability_zone     = ["ap-south-1a", "ap-south-1b"]
  instance_subnets        = [data.terraform_remote_state.vpc.outputs.private_subnet_ids[0][2], data.terraform_remote_state.vpc.outputs.private_subnet_ids[0][3]]
  launch_template_version = "$Latest"

}

#    module "rds-mssql" {
#    source  = "OT-CLOUD-KIT/rds-mssql/aws"
#    version = "0.0.1"
#    database_security_groups = var.database_security_groups 
#    database_subnet_ids      = [data.terraform_remote_state.vpc.outputs.private_subnet_ids[0][4], data.terraform_remote_state.vpc.outputs.private_subnet_ids[0][5]]
#    engine_name              = var.engine_name
#    db_name                  = var.db_name
#    username                 = var.username
#    password                 = var.password
#    delete_automated_backups = var.delete_automated_backups
#    skip_final_snapshot      = var.skip_final_snapshot
#    public_access            = var.public_access
#    instance_class           = var.instance_class
#    allocated_storage        = var.allocated_storage
#    tags                     = var.tags
# }
