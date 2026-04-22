terraform {
  backend "s3" {
    #bucket         = "danit-devops-tf-state"
    #key            = "eks/terraform.tfstate"
    bucket         = "tf-tfstate-danit-11"
    key            = "state/allex-devops/final-project/terraform.tfstate"
    encrypt        = true
    region         = "eu-central-1"
    dynamodb_table = "lock-tf-eks"
    # dynamo key LockID
    # Params tekan from -backend-config when terraform init
    #profile = 
  }
}


