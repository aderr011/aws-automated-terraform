remote_state {
  backend = "s3"
  config = {
    bucket         = "ad-state-file-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "ad-state-lock-dynamodb"
    region         = "us-west-2"
  }
}

terraform {
  extra_arguments "common_vars" {
    commands = ["plan", "apply"]
    required_var_files = [
      "${get_parent_terragrunt_dir()}/vars.tfvars.json"
    ]
  }
}