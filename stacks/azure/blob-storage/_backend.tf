# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket         = "bac-terramate-example-terraform-state-backend"
    dynamodb_table = "terraform_state"
    encrypt        = true
    key            = "terraform/stacks/azure/blob-storage/terraform.tfstate"
    region         = "eu-west-1"
  }
}
