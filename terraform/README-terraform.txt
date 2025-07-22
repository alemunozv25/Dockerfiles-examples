--
--
Terraform latest - direct

docker build -f terraform-direct-latest-Dockerfile -t terraform-direct-latest:terraform --no-cache --progress=plain .

. Examine Image Size
docker images | grep -E 'TAG|terraform-direct-latest'   
REPOSITORY                         TAG         IMAGE ID       CREATED              SIZE
terraform-direct-latest            terraform   078472722426   About a minute ago   118MB

. Run the container
docker run terraform-direct-latest:terraform
Terraform v1.12.2
on linux_arm64

. Check terraform version 
docker run --entrypoint sh terraform-direct-latest:terraform -c 'terraform --version'
Terraform v1.12.2
on linux_arm64

--
-- 
Terraform via Ubuntu

docker build -f terraform-ubuntu24-Dockerfile -t terraform-ubuntu24:terraform --no-cache --progress=plain .

. Examine Image Size
docker images | grep -E 'TAG|terraform-ubuntu24'   
REPOSITORY                         TAG         IMAGE ID       CREATED          SIZE
terraform-ubuntu24                 terraform   666ccf623681   2 minutes ago    196M

. Run the container
docker run terraform-ubuntu24:terraform
Terraform v1.11.4
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.12.2. You can update by downloading from https://developer.hashicorp.com/terraform/install


. Check terraform version 
 docker run --entrypoint sh terraform-ubuntu24:terraform -c 'terraform --version'
Terraform v1.11.4
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.12.2. You can update by downloading from https://developer.hashicorp.com/terraform/install
