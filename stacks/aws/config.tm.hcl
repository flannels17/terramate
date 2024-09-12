globals "terraform" "providers" "aws" {
  enabled = true

  source  = "hashicorp/aws"
  version = "~> 5.0"
  config = {
    region = "eu-west-1"
  }
}

globals "terraform" "providers" "aws.east-1" {
  config = {
    region = "us-east-1"
  }
}
