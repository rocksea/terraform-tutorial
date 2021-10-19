variable "region" {
  type = string
}
variable "app_name" {
  type = string
}
variable "namespace" {
  type = string
}
variable "stage" {
  type = string
}
variable "name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "autoscale_max" {
  type = number
}
variable "vpc_id" {
  type = string
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "app_env" {
  type = map(string)
}
variable "healthcheck_url" {
  type = string
}
variable "additional_settings" {
  type = list(object({
    namespace: string
    name: string
    value: string
  }))
}
variable "availability_zones" {
  type = list(string)
}

locals {
  region = var.region
  app_name = var.app_name

  env = terraform.workspace

  vpc_id = var.vpc_id
  public_subnet_ids = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids

  # Beanstalk
  namespace = var.namespace
  stage = var.stage
  name = var.name
  instance_type = var.instance_type
  autoscale_max = var.autoscale_max
  app_env = var.app_env
  healthcheck_url = var.healthcheck_url
  additional_settings = var.additional_settings
  availability_zones = var.availability_zones
}
