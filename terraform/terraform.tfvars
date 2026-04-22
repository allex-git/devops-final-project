# AWS account config
region = "eu-central-1"

# General for all infrastructure
# This is the name prefix for all infra components
name = "allex-devops"


#vpc_id = "vpc-0bb5f828fddfbf9e7"
#vpc_id =  ["subnet-025cd4585ef90536e", "subnet-04942409f4d92aa7e", "subnet-0c9c5d9a519bd2253"]


tags = {
  Environment = "test"
  TfControl   = "true"
  Name       = "allex-devops-vpc"
  created_by = "allex-devops"
}


zone_name = "devops11.test-danit.com"
