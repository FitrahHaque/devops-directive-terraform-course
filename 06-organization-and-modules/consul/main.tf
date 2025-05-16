terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  # See /code/03-basics/aws-backend
 backend "s3" {
    bucket         = "terraform-state-ihtemad"
    key            = "state_utils/06/terraform.tfstate"
    region         = "us-east-1"
    # use_lockfile   = true
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

############################################################
##
## NOTE: if you are deploying this in your production setup
## follow the instructions in the github repo on how to modify
## deploying with the defaults here as an example of the power
## of modules.
##
## REPO: https://github.com/hashicorp/terraform-aws-consul
##
############################################################
module "consul" {
  source = "git::https://github.com/hashicorp/terraform-aws-consul.git"
}
