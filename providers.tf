
provider "aws" {
  region  = "us-east-1"
  profile = "default"
  default_tags {
    tags = {
      terraform = "ManagedBy ${var.Owner}"
    }
  }
}

terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
