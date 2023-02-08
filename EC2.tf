provider "aws" {
    access_key = ""
    secret_key = ""
    region = ""
}

resource "aws_instance" "Terraform_server" {
    ami = "ami-0aa7d40eeae50c9a9"
    instance_type = "t2.micro"
    subnet_id = "subnet-0edadc699db2a039a"                      # Here we will give the PUBLIC SUBNET
    security_group = "sg-050d67c53af34439e"
    keypair = "aws_key_pair.key.id"
    tags = {
        Name = "Testing_Server"
    }
}

resource "aws_key_pair" "key" {
    key_name   = "Testing"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}


# In the place of the Publickey we have to give the Public Key of the KeyPair that we used to craete the Instance

# Now, To keep the Access_Key & Secret_key ID's----> SECRET, we will Create the IAM User and Copyy the Access and Secret key Credentials 
#  and, Install the AWS CLI and we do the AWS Configure and give the IAM USER Creds there 
# To keep the AWS Provider Dtls Safe

####### TERRAFORM STEPS #######
# 1) Terraform init
# 2) Terraform validate
# 3) tTrraform plan
# 4) Terraform apply 


# If we check in the AWS EC2 Instance Console we will get the Instance Live 

# To destroy the Instance using the Terraform Command we use the CMMND, 

# 5) Terraform destroy
