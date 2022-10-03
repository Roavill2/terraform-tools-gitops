module "dev_cluster" {
  source = "github.com/cloud-native-toolkit/terraform-ocp-login.git"

  server_url = var.server_url
  login_user = "apikey"
  login_password = var.ibmcloud_api_key
  login_token = var.login_token
  ingress_subdomain = var.ingress_subdomain
  ca_cert_file = var.ca_cert_file
}

resource null_resource output_kubeconfig {
  provisioner "local-exec" {
    command = "echo '${module.dev_cluster.platform.kubeconfig}' > .kubeconfig"
  }
}
