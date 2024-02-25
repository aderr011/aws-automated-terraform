remote_state {
    backend = "s3"
    config = {
        bucket = "ad-state-file-bucket"
        key = "${path_relative_to_include()}/terraform.tfstate"
        encrypt = true
        dynamodb_table = "ad-state-lock-dynamodb"
        region = "us-west-2"
    }
}