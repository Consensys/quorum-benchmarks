
variable "region" {
  default = "ap-southeast-2"
}

variable "azs" {
  type    = list(string)
  default = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

variable "caliper_version" {
  default = "v0.3.0"
}

variable "vpc_name" {
  default = "ibft4caliper"
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
  default = "yeti-syd"
}

# the path to this key pair locally
# this is used by terrafrom to ssh in and run any provisioning steps
# NOTE/GOTCHA: be sure to use the "~" token in place of the home directory path
variable "default_ssh_key_path" {
  default = "~/.ssh/yeti-syd.pem"
}

variable "user_ssh_public_keys" {
  type = "list"
  default = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDur5oTgFpg4mOYLi8Mv0enylvxY0aZS2ra1J6sEW8DnZAg/sl5DbOm7+zClH1nLU3ZUTiZKFubHANx12vL/t9AezpHboMb8nJrQAGsNDCjHlquEQxdopYprSPmblxLjofQqvhGAZxr4OgCRd1NkE1PGrok0Ui8eqfqR2//3XzBiZD7yKHe8Y4qszsFnA57b4ccnx08ZJjt6lbPPBfZpxNNtg3Hm6pUZhKjJx5lYm4jlt3g3thrwlV8rkK1deBVJOXnw2talIonuMucJNJym50CRL8JJy1mvod9T6jQ1G6O3ZKwHRvYKEfqu40npgKVkXh3CZpqOUcTCZjJ1r5+ZYtoKMbjlfLUgQymrGtb29+u8yfjFcZ84H08kJnvafAFzGlHHQq4rZguLUYAQ6PlRXJe+TbbRnZq4geEj1s5miamR7szt0p5W1zVS0SSOq7AwjX7Ep+DCQDpzo5ELnfO7clLRXQfpYFhM9xIJu7nkhJiPjB1mdIPeQMiFCAdAvRvjTaJyp/yE+iOQrOJ3gTUHn5R7HSYTFPRD+DCavb+ELkNpwkib9I1Twa0qZ1+Qy0F/9U1JE1UthGeAiWAZp10B/myBrsOQbrVBefnGf+gUVRAvx64aHffN/Fo0hRFcBc1S00UdM/qDQSytA9T29M9xRR5yMnctN8gOnG1lka3/6jLyQ== joshua.fernandes@consensys.net",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBAzFxLCARGTGj5VJO0DxZNMTTzEaRQw52rl37D92tEB9gVmfcBBxEFITCuYMYymX6tdB73SCcoo1okrBNZxJLCa7Sx/q9EUUdxMd6jJ6DllRapzZ+8137FS47VxIN6UghmZzGqyhoBCSX16bwmPFwrx+YssfhvNVEU1EDClwIpIqqjkGRNR6q2E9qZG92bn+zlI88DFv3kTO8x/Np8JXvMUbTBoAtyzcJiG4Wn0GNd6wIj+uKsB70lp9uDoKwc38hYXXLM2iPBt5OOTlV3qFm/eA+zun9ERr3wxwELPuiswADStH6CTeOA6jbE9j9kbUL50Cn2lGufrkdLxOMme35 ben.burns@consensys.net"
  ]
}

# make sure the besu_version and download_url match in the number
# eg: 1.3.8 for version is used for anything that contains 1.3.8-rc.. or 1.3.8-snapshot.. etc
variable "besu_version" {
  default = "1.3.8"
}

variable "besu_download_url" {
  default = "https://bintray.com/hyperledger-org/besu-repo/download_file?file_path=besu-{{besu_version}}.tar.gz"
}

variable "node_count" {
  default = 3
}

variable "node_instance_type" {
  default = "t3.medium"
}
