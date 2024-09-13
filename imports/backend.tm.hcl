generate_hcl "_backend.tf" {
  content {
    terraform {
      backend "s3" {
        region         = global.terraform.backend.s3.region
        bucket         = global.terraform.backend.s3.bucket
        key            = "terraform/${terramate.stack.path.relative}/terraform.tfstate"
        encrypt        = true
        dynamodb_table = "terraform_state_lock"
      }
    }
  }
}
