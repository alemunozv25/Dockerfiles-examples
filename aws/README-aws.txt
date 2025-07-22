--
AWS CLI without using --platform option for container
docker build -f awscli-ubuntu.Dockerfile -t awscli-ubuntu:aws .

.Examine Image Size
docker images | grep -E 'TAG|awscli-ubuntu'
REPOSITORY                         TAG         IMAGE ID       CREATED             SIZE
awscli-ubuntu                      aws         7c6f88f9514d   16 minutes ago      763MB


. Run the container
docker run awscli-ubuntu:aws
rosetta error: failed to open elf at /lib64/ld-linux-x86-64.so.2
 %   

--> This fails because of the difference between host platform (linux/arm64/v8) with M4 chip and the docker image platform (linux/amd64)


--
--
AWS CLI using --platform option for container
docker build --platform linux/amd64 -f awscli-ubuntu-amd.Dockerfile -t awscli-amd64-ubuntu:aws .

.Examine Image Size
docker images | grep -E 'TAG|awscli-amd64-ubuntu'
REPOSITORY                         TAG         IMAGE ID       CREATED             SIZE
awscli-amd64-ubuntu                aws         a64cec513f1a   5 minutes ago       6

. Run the container
docker run awscli-amd64-ubuntu:aws                                                          
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
aws-cli/2.27.57 Python/3.13.4 Linux/6.6.93-0-virt exe/x86_64.ubuntu.24

docker run --platform linux/amd64 awscli-amd64-ubuntu:aws
aws-cli/2.27.57 Python/3.13.4 Linux/6.6.93-0-virt exe/x86_64.ubuntu.24

. Find AWS CLI version
docker run --platform linux/amd64 --entrypoint sh awscli-amd64-ubuntu:aws -c 'aws --version'
aws-cli/2.27.57 Python/3.13.4 Linux/6.6.93-0-virt exe/x86_64.ubuntu.24

--
--
AWS CDK from node base image
docker build -f aws-cdk.Dockerfile -t aws-cdk:aws .

.Examine Image Size
docker images | grep -E 'TAG|aws-cdk'
REPOSITORY                         TAG         IMAGE ID       CREATED              SIZE
aws-cdk                            aws         f7b8f1e7db55   About a minute ago   1.16GB

. Run the container
docker run aws-cdk:aws       
2.1021.0 (build 059c862)

. Find AWS CDK version
docker run --entrypoint sh aws-cdk:aws -c 'cdk --version'
2.1021.0 (build 059c862)

. Find NODE version
docker run --entrypoint sh aws-cdk:aws -c 'node --version'
v22.17.1


--
--
AWS CDK from ubuntu image
docker build -f aws-cdk-ubuntu.Dockerfile -t aws-cdk-ubuntu:aws .

.Examine Image Size
docker images | grep -E 'TAG|aws-cdk-ubuntu'
REPOSITORY                         TAG         IMAGE ID       CREATED             SIZE
aws-cdk-ubuntu                     aws         9fda0cd4db78   5 minutes ago       427MB

. Run the container
docker run aws-cdk-ubuntu:aws       
2.1021.0 (build 059c862)

. Find AWS CDK version
docker run --entrypoint sh aws-cdk-ubuntu:aws -c 'cdk --version'
2.1021.0 (build 059c862)

. Find NODE version
docker run --entrypoint sh aws-cdk-ubuntu:aws -c 'node --version'
v22.17.1

--
--
AWS CDK from ubuntu image
docker build -f aws-terraform-tools.Dockerfile -t aws-terraform-tools:aws .

.Examine Image Size
docker images | grep -E 'TAG|aws-terraform-tools'
REPOSITORY                         TAG         IMAGE ID       CREATED          SIZE
aws-terraform-tools                aws         f86cf3d849d2   19 minutes ago   1.12GB

. Run the container
docker run aws-terraform-tools:aws       
2.1021.0 (build 059c862)


. Find AWS CDK version
docker run --entrypoint sh aws-terraform-tools:aws -c 'cdk --version'
2.1021.0 (build 059c862)

. Find NODE version
docker run --entrypoint sh aws-terraform-tools:aws -c 'node --version'
v22.17.1

. Find AWS CLI version
docker run --entrypoint sh aws-terraform-tools:aws -c 'aws --version'
rosetta error: failed to open elf at /lib64/ld-linux-x86-64.so.2
 Trace/breakpoint trap (core dumped)
--> This fails because of the difference between host platform (linux/arm64/v8) with M4 chip and the docker image platform (linux/amd64)

. Find terraform version
docker run --entrypoint sh aws-terraform-tools:aws -c 'terraform --version'
Terraform v1.12.2
on linux_amd64

---
---
AWS CDK from ubuntu image and using --platform option
docker build --platform linux/amd64 -f aws-terraform-tools-amd.Dockerfile -t aws-terraform-tools-amd:aws .

.Examine Image Size
docker images | grep -E 'TAG|aws-terraform-tools-amd'
REPOSITORY                         TAG         IMAGE ID       CREATED          SIZE
aws-terraform-tools-amd            aws         ae4fcc260e9b   4 minutes ago    1.03GB

. Run the container
docker run --platform linux/amd64 aws-terraform-tools-amd:aws       
2.1021.0 (build 059c862)


. Find AWS CDK version
docker run --platform linux/amd64 --entrypoint sh aws-terraform-tools-amd:aws -c 'cdk --version'
2.1021.0 (build 059c862)

. Find NODE version
docker run --platform linux/amd64 --entrypoint sh aws-terraform-tools-amd:aws -c 'node --version'
v22.17.1

. Find AWS CLI version
docker run --platform linux/amd64 --entrypoint sh aws-terraform-tools-amd:aws -c 'aws --version'
aws-cli/2.27.57 Python/3.13.4 Linux/6.6.93-0-virt exe/x86_64.ubuntu.24

. Find terraform version
docker run --platform linux/amd64 --entrypoint sh aws-terraform-tools-amd:aws -c 'terraform --version'
Terraform v1.12.2
on linux_amd64


---
Comparison of Images Sizes
docker images | grep -E 'TAG|aws'                    
REPOSITORY                         TAG         IMAGE ID       CREATED          SIZE
aws-terraform-tools-amd            aws         ae4fcc260e9b   15 minutes ago   1.03GB
aws-terraform-tools                aws         f86cf3d849d2   21 minutes ago   1.12GB
aws-cdk                            aws         f03711258431   39 minutes ago   1.16GB
aws-cdk-ubuntu                     aws         9fda0cd4db78   39 minutes ago   427MB
awscli-amd64-ubuntu                aws         a64cec513f1a   2 hours ago      673MB
awscli-ubuntu                      aws         7c6f88f9514d   2 hours ago      763MB
