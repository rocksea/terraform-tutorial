module "elastic_beanstalk_application" {
  source = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application.git?ref=tags/0.3.0"
  namespace = local.namespace
  stage = local.stage
  name = local.app_name
  description = "${local.name}(${local.env}) beanstalk application"
}

module "elastic_beanstalk_environment" {
  source = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment.git?ref=master"

  namespace = local.namespace
  stage = local.stage
  name = local.app_name

  description = "${local.name}(${local.env}) beanstalk application environment"
  region = local.region
  instance_type = local.instance_type

  autoscale_min = local.env == "dev" ? 1 : 2
  autoscale_max = local.env == "dev" ? 3 : local.autoscale_max
  updating_min_in_service = local.env == "dev" ? 0 : 1
  updating_max_batch = 1
  loadbalancer_type = "application"
  environment_type = "LoadBalanced"

  availability_zone_selector = "Any 2"
  tier = "WebServer"

  vpc_id = local.vpc_id
  loadbalancer_subnets = local.public_subnet_ids
  application_subnets = local.private_subnet_ids

  security_groups = [
    aws_security_group.http_sg.id,
    aws_security_group.https_sg.id,
    aws_security_group.outbound_to_all.id
  ]

  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.5 running Docker"

  env_vars = local.app_env
  additional_settings = local.additional_settings
  healthcheck_url = local.healthcheck_url
  elb_scheme = "public"

  # autoscale
  autoscale_unit = "Percent"
  autoscale_lower_bound = 25
  autoscale_lower_increment = -1
  autoscale_upper_bound = 65
  autoscale_upper_increment = 1
  autoscale_measure_name = "CPUUtilization"
  autoscale_statistic = "Average"

  # volume
  root_volume_size = 25
  root_volume_type = "gp2"

  rolling_update_enabled = true
  rolling_update_type = "Health"

  force_destroy = true
}
