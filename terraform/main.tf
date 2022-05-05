terraform {
  backend "s3" {
    bucket  = "stravito-infrastructure-assets"
    key     = "platform/tfstates/pev2.tfstate"
    region  = "eu-west-1"
    encrypt = true
    profile = "prod-terraform"
  }
}

data "aws_acm_certificate" "stravito_com" {
  domain   = "*.dev.stravito.com"
  statuses = ["ISSUED"]
  provider = aws.cloudfront
}

provider "aws" {
  region  = "eu-west-1"
  profile = "dev-terraform"
  allowed_account_ids = ["650952641846"]

  default_tags {
    tags = {
      Terraform = true
      Environment = "dev"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dev-terraform"
  allowed_account_ids = ["650952641846"]

  alias = "cloudfront"

  default_tags {
    tags = {
      Terraform = true
      Environment = "dev"
    }
  }
}

locals {
  s3_origin_id = "pev2-bucket-origin-id"
}
