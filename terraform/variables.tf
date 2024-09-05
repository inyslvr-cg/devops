variable "instance_count" {
  type        = number
  default     = 1
  description = "The number of instances to create"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where the resources live"
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for the instance(s)"
  default     = "t2.micro"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR value of vpc"
  default     = "10.0.0.0/24"
}

variable "subnet_cidr" {
  type        = string
  description = "The CIDR value of subnet"
  default     = "10.0.0.0/27" 
}

variable "subnet_az" {
  type        = string
  default     = "us-east-1a"
  description = "The Availability zone for the subnet"
}

variable "ami_id" {
  type        = string
  description = "The AMI image used to create the instance"
  default     = "ami-0182f373e66f89c85" #amazon linux 2023 ami in us-east-1
}