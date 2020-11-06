
variable "region" {
  default = "us-east-1"
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


variable "caliper_repo" {
  default = "https://github.com/hyperledger/caliper"
}

variable "caliper_version" {
  default = "v0.3.2"
  #default = "include_deployer_addr_in_context"
}

variable "vpc_name" {
  default = "ps-vpc-ohio"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "intra_subnets" {
  type    = list(string)
  default = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

variable "login_user" {
  default = "ubuntu"
}

# the name of the ssh key pair in aws
# this tells aws to provision instances with this keypair
variable "default_ssh_key" {
  default = "pantheon-dev"
}

# the path to this key pair locally
# this is used by terrafrom to ssh in and run any provisioning steps
# NOTE/GOTCHA: be sure to use the "~" token in place of the home directory path
variable "default_ssh_key_path" {
  default = "~/.ssh/pantheon-dev.pem"
}

variable "user_ssh_public_keys" {
  type = "list"
  default = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDur5oTgFpg4mOYLi8Mv0enylvxY0aZS2ra1J6sEW8DnZAg/sl5DbOm7+zClH1nLU3ZUTiZKFubHANx12vL/t9AezpHboMb8nJrQAGsNDCjHlquEQxdopYprSPmblxLjofQqvhGAZxr4OgCRd1NkE1PGrok0Ui8eqfqR2//3XzBiZD7yKHe8Y4qszsFnA57b4ccnx08ZJjt6lbPPBfZpxNNtg3Hm6pUZhKjJx5lYm4jlt3g3thrwlV8rkK1deBVJOXnw2talIonuMucJNJym50CRL8JJy1mvod9T6jQ1G6O3ZKwHRvYKEfqu40npgKVkXh3CZpqOUcTCZjJ1r5+ZYtoKMbjlfLUgQymrGtb29+u8yfjFcZ84H08kJnvafAFzGlHHQq4rZguLUYAQ6PlRXJe+TbbRnZq4geEj1s5miamR7szt0p5W1zVS0SSOq7AwjX7Ep+DCQDpzo5ELnfO7clLRXQfpYFhM9xIJu7nkhJiPjB1mdIPeQMiFCAdAvRvjTaJyp/yE+iOQrOJ3gTUHn5R7HSYTFPRD+DCavb+ELkNpwkib9I1Twa0qZ1+Qy0F/9U1JE1UthGeAiWAZp10B/myBrsOQbrVBefnGf+gUVRAvx64aHffN/Fo0hRFcBc1S00UdM/qDQSytA9T29M9xRR5yMnctN8gOnG1lka3/6jLyQ== joshua.fernandes@consensys.net",
   "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCOgL4dAgLgDUFScirkOgC5Ewj5f4bDLdePe8+EgkuuxV1KpU+LHLPgnUBDnlLgve+FFn6sDBTxFn2Ev07GOv85eFdLlBe+XxU/SgR4R+pI8ef2F0HdAY9hWqzkBun1BKVQxcB9m9tVstXafZDHqESlnvHogw3SwTyavbJF8e7AcZgNiVugdiMr+oN8jhBevvODmZomRMVkm3Fw2jHT44xWKCSA3a6QD88MM8nR6IaQgfrmUI3+9/b/0+Rj/qHrY+L/rFcKZmVFmWNknkq5iT8M6A3IAkS3WXqrdARC7/TZpcknzknX0tQw78L4pfgfNDOEjX5QUNZAAE5sD9D6eZBN"
  ]
}

# make sure the besu_version and download_url match in the number
# eg: 1.3.8 for version is used for anything that contains 1.3.8-rc.. or 1.3.8-snapshot.. etc
variable "besu_version" {
  default = "1.5.5"
}

variable "besu_download_url" {
  default = "https://bintray.com/hyperledger-org/besu-repo/download_file?file_path=besu-{{besu_version}}.tar.gz"
}

variable "node_count" {
  default = 3
}

variable "caliper_instance_type" {
  default = "c5.2xlarge"
}

variable "node_instance_type" {
  default = "c5d.4xlarge"
}

variable "rpcnode_instance_type" {
  default = "c5d.4xlarge"
}

variable "bootnode_instance_type" {
  default = "c5d.4xlarge"
}
