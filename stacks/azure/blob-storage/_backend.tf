# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket         = "bac-terramate-example-terraform-state-backend"
    dynamodb_table = "terraform_state"
    encrypt        = true
    key            = "terraform/stacks/by-id/1dfd1546-8985-41d0-8035-94aece5c3338/terraform.tfstate"
    region         = "eu-west-1"
  }
}
