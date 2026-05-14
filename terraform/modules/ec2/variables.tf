variable "project_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "ami" {
  type = string
}

variable "key_name" {
  type = string
  
}