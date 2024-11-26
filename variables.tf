variable "access_key_id" {
  type    = string
  default = ""
}

variable "secret_access_key" {
  type    = string
  default = ""
}

variable "ENV_NAME" {
  type    = string
}

variable "acm_domain" {
  type    = string
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "http_whitelisted_ips" {
  type    = list(string)
  default = ["85.198.144.34/32", "91.193.129.182/32", "176.122.116.167/32", "80.254.2.190/32", "18.204.192.177/32", "18.211.30.31/32", "34.232.225.0/32", "34.232.246.163/32"]
}

/*variable "AMIS" {
  default =  {
    us-east-2 = "ami-0b0fa20f212e7257d"
    us-east-1 = "ami-0cfac3931b2a799d1"
    us-west-1 = "ami-0902b0c92f1f96cfa"
    us-west-2 = "ami-08a53218d9216e905"
    ap-east-1 = "ami-0b08337a1acf3c3e8"
    ap-northeast-1 = "ami-0241cbc4a131b240b"
    ap-northeast-2 = "ami-05e1ccb7a2556b9f6"
    ap-south-1 = "ami-00d702f4f97505e48"
    ap-southeast-1 = "ami-0265b4b6249a65d67"
    ap-southeast-2 = "ami-0c65464891ebef8be"
    ca-central-1 = "ami-05696eee30b579924"
    eu-central-1 = "ami-0134bbbf8dbf52a1c"
    eu-north-1 = "ami-0828202fd23cfc483"
    eu-west-1 = "ami-0a889af68c555f069"
    eu-west-2 = "ami-0ec741f9ad4ced8a8"
    eu-west-3 = "ami-0fc468390088adc22"
    me-south-1 = "ami-06ada8067f49c901f"
    sa-east-1 = "ami-0cc9ac1ec02618a72"
  }
}*/

#Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
variable "AMIS" {
  default = {
    us-east-2 = "ami-07efac79022b86107"
    us-east-1 = "ami-0dba2cb6798deb6d8"
    us-west-1 = "ami-021809d9177640a20"
    us-west-2 = "ami-06e54d05255faf8f6"
    ca-central-1 = "ami-0edab43b6fa892279"
    eu-central-1 = "ami-0c960b947cbb2dd16"
    eu-west-1 = "ami-06fd8a495a537da8b"
    eu-west-2 = "ami-05c424d59413a2876"
    eu-west-3 = "ami-078db6d55a16afc82"
    eu-north-1 = "ami-008dea09a148cea39"
    sa-east-1 = "ami-02dc8ad50da58fffd"
  }
}

variable "tag" {
  type    = string
  default = "preprod"
}
