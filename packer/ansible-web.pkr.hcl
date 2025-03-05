packer {
  required_plugins {
    # COMPLETE ME
    # add necessary plugins for ansible and aws

    amazon = {
      version = ">= 1.3"
      source  = "github.com/hashicorp/amazon"
    }

    ansible = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/ansible"
    }

  }
}

  source "amazon-ebs" "ubuntu" {
    # COMPLETE ME
    # add configuration to use Ubuntu 24.04 image as source image

  ami_name      = "web-nginx-aws"
  instance_type = "t2.micro"
  region        = "us-west-2"

  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240725"

      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] 
    
	}
  ssh_username = "ubuntu"
  }

  build {
    # COMPLETE ME
    name = "packer-ansible-nginx"

    # add configuration to: 
    # - use the source image specified above

    sources = [
    "source.amazon-ebs.ubuntu"
    ]

    provisioner "shell" {
		inline = [
			"echo installing ansible",
			"sudo apt update",
			"sudo apt install -y software-properties-common",      
			"sudo add-apt-repository --yes --update ppa:ansible/ansible",
		    "sudo apt install -y ansible",
		  ]
    }

    # - use the "ansible" provisioner to run the playbook in the ansible directory

    provisioner "ansible" {
      ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_NOCOWS=1"]
      user = "ubuntu"
      playbook_file = "../ansible/playbook.yml"
    }

  }