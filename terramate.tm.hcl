terramate {
  required_version = "~> 0.10"

  config {
    generate {
      hcl_magic_header_comment_style = "#"
    }

    experiments = [
      "scripts"
    ]

    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.terraform-cache-dir"
      }
    }
  }
}

import {
  source = "./imports/*.tm.hcl"
}
