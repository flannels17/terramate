# TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "s3" {
    bucket         = "bac-terramate-demo-backend"
    dynamodb_table = "terraform_state_lock"
    encrypt        = true
    key            = "terraform/stacks/aws/dev/opensearch/terraform.tfstate"
    region         = "eu-west-1"
  }
}
