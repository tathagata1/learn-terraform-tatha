terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



provider "aws" {
  region = var.region

}

resource "aws_s3_bucket" "tf_state" {
  bucket        = var.s3
  force_destroy = true
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "tf-locks-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}

resource "aws_instance" "test_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  tags = {
    Name = "LearnTerraformInstance"
  }

}
