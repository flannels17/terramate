# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket         = "bac-terramate-example-terraform-state-backend"
    dynamodb_table = "terraform_state"
    encrypt        = true
    key            = "terraform/stacks/aws/dev/opensearch/terraform.tfstate"
    region         = "eu-west-1"
  }
}
