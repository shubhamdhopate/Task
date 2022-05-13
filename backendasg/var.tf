variable "route53_zone_id" {
  type    = string
  default = "Z0281557JZG3TGTR5JDX"
}
variable "route53_name" {
  type    = string
  default = "www.mydevopsprojects.co.in"
}
variable "alb_dns_cname" {
  type    = list(string)
  default = ["aws_lb.test.dns_name"]
}
variable "ttl" {
  type    = number
  default = 10
}

variable "env_name" {
  type    = string
  default = "dev"
}

variable "applicaton_name" {
  type    = string
  default = "demo-application"
}
variable "applicaton_port" {
  type    = number
  default = 80
}
variable "applicaton_health_check_target" {
  type    = string
  default = "/"
}
variable "tg_target_type" {
  type    = string
  default = "instance"
}
variable "tg_protocol" {
  type    = string
  default = "HTTP"
}
 variable "listener_arn" {
   type    = string 
   default = "arn:aws:elasticloadbalancing:ap-south-1:253942872677:listener/app/demo-alb/901f400a8ac5388e/2ef4d9c15bd49474"
 }
variable "priority" {
  type    = number
  default = 10
}

variable "listener_rule_condition" {
  type    = string
  default = "host-header"
}
variable "listener_rule_condition_values" {
  type    = list(string)
  default = ["www.mydevopsprojects.co.in"] 
}

variable "ami_id" {
  type    = string
  default = "ami-05ba3a39a75be1ec4"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_key_name" {
  type    = string
  default = "shubham_key"
}
variable "volume_size" {
  type    = number
  default = 10
}

variable "engine_name" {
  description = "name of db engine"
  type        = string
  default     = "sqlserver-ex"
}

variable "db_name" {
  description = "Enter the name of the database to be created inside DB Instance"
  type        = string
  default     = null
}


variable "username" {
  description = "username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Enter the password"
  type        = string
  default     = "Shubham$123"
}


variable "delete_automated_backups" {
  description = "delete automated backup (yes or no)"
  type        = bool
  default     = true
}


variable "skip_final_snapshot" {
  description = "skip backup"
  type        = bool
  default     = true
}

variable "public_access" {
  description = "Publically accessible"
  type        = bool
  default     = false
}


variable "instance_class" {
  description = "type of instance"
  type        = string
  default     = "db.t3.small"
}


variable "allocated_storage" {
  description = "storage size"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}


variable "database_security_groups" {
  description = "security group of database"
  type        = list(any)
  default     = []
}

