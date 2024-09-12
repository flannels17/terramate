# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket         = "bac-terramate-example-terraform-state-backend"
    dynamodb_table = "terraform_state"
    encrypt        = true
    key            = "terraform/stacks/by-id/178ac014-b842-4560-bc45-be876949d2d6/terraform.tfstate"
    region         = "eu-west-1"
  }
}
