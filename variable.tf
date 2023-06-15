variable "iam" {
    default = "ami-0c94855ba95c71c99"
  }
  variable "instance_type" {
    default = "t2.micro"
  }
  /*variable "public_key" {
    type = string
    default ="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5GTbPycYNxD5XwWY3MVGyKos6QoG67S9iV1gVHRco7Pa011AXS/u3fHDWQpUptEsnTuxMO+QtpBJ7ufpczemEpo6e1Bj8B9kEqUffJy1bS15QswKejMnUJxBKfq6s9xqgVKY8dTIYLEU8sl9LNcINuGu92Ay52Zv2mkDFP0L4n+ot/8IY8cPsv7e6Zexu5gQJG91dKo0URe+zrig3ZAIDgTRg6ySY8ze3D4U2C3buhKubuG2H/aEpbrEKE7nftjzhr0kScv6fgyDiqD1EnXRV80WO83hQHW+D93gTe4rUZ3xkGluJAqouPMHUz2AgzkYtiwMJ3cfSK88EC2OvXhghr8Ng7xPpWulY/UtwDxp7eiU7geze1eJ+0VimRWgXLEFpX0cq6tKSYuqUbCCTXwU1C1iBB/kb/tpb0m5/uNrFzfhdYtM1iHAqTY1RAZ6hqoiumVoScGpfS1+I0drVpNDjm9YNr1aN4a0HN1g2rIgbKwqr/t/z/7ZpyalwSeqo6Dbh6gMP/QUR9R9TXDScBPgRq/8CaqfmNgTe7tDM86HvzTc1/og9CYJCwQ+DnENg693tyEIGxdbdjoCYcpTRAk4hdaTtwBrPm19Gq8Dth6M1xU2FP/ju/wRV1S0/t8q0FeUSw1+72ly2WyCMCQmrxC86GGn9eP/yMPNCaVKVavDovQ== l33@L33"
}*/ 
#used a file function in main.tf so this is line is deprciated
  variable "key_pair_name" {
    type = string
    default = "demokey"
    
  }