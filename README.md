packer init .

this command will initialize packer by downloading the required plugins defined in the packer file

packer build file_name

this command will begin creating the image that the file has defined. this image will become an Amazon AMI

terraform init

this command will initialize terraform by downloading the required plugins defined in the terraform file

terraform apply

this command will build an amazon EC2 instance with the Amazon AMI defined in the terraform file (should be the Amazon AMI created with packer)

terraform destroy

this command will destroy all artifacts terraform has created
