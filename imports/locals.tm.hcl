generate_hcl "_locals.tf" {
  content {
    locals {
      common_tags = {
        Source                  = "IAC/terraform"
        TerraformPath           = "${terramate.stack.path.relative}"
        "ebbr:service"          = "ICTCF"
        "ebbr:cost-center"      = "CESS71E"
        "ebbr:productowner"     = "CloudFoundation"
        "ebbr:technicalcontact" = "cloudfoundation.alerts@brusselsairport.be"
        "ebbr:environment"      = global.environment
      }
    }
  }
}
