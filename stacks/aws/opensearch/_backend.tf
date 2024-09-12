# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket         = "bac-terramate-example-terraform-state-backend"
    dynamodb_table = "terraform_state"
    encrypt        = true
    key            = "terraform/stacks/by-id/847ee7f1-9fb8-422f-9ac1-372640fa553a/terraform.tfstate"
    region         = "eu-west-1"
  }
}
