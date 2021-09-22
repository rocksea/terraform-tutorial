# Terraform 
Terraform is Infrastructure as Code for Managing infrastructure.

### Command
The commands are divided into three steps.

```
$ terraform init

$ terraform plan

$ terraform apply
```

### Installing AWS CLI on MacOS
```
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

### Terraform Modules
- [VPC](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [ElasticBeanstalk](https://registry.terraform.io/modules/cloudposse/elastic-beanstalk-environment/aws/latest)

### Find AMI 
You must select an AMI to launch EC2 Instance.
[A link to find AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html)

```
aws ec2 describe-images \
    --owners 099720109477 \
    --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????" "Name=state,Values=available" \
    --query "reverse(sort_by(Images, &Name))[:1].ImageId" \
    --output text
```
