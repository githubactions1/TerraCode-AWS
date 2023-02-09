provider "aws"{
    aws_access_key = ""
    aws_secret_key = ""
    region = ""
}

resource "aws_s3_bucket" "my_s3_bucket" {
    bucket_prefix = "my-s3bucket"
    acl = "private"
    versioning {
        enabled = true
    }
    tags ={
        Name = s3bucket
        default = {
            environmet = Dev
            terraform = true
        }
    }
}

