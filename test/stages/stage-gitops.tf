module "gitops" {
  source = "./module"

  host = var.git_host
  org  = ""
  repo = var.git_repo
  username = var.git_username
  token = var.git_token
  project = var.git_project
  gitops_namespace = var.gitops_namespace
  sealed_secrets_cert = module.cert.cert
  strict = true
}

module setup_clis {
  source = "github.com/cloud-native-toolkit/terraform-util-clis.git"
}

resource null_resource gitops_output {
  provisioner "local-exec" {
    command = "echo -n '${module.gitops.config_repo}' > git_repo"
  }

  provisioner "local-exec" {
    command = "echo -n '${module.gitops.config_username}' > git_username"
  }

  provisioner "local-exec" {
    command = "echo -n '${module.gitops.config_token}' > git_token"
  }

  provisioner "local-exec" {
    command = "echo -n '${module.setup_clis.bin_dir}' > .bindir"
  }
}
