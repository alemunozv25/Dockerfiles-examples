FROM ubuntu:24.04

ARG TERRAFORM_VERSION=1.12.2

# Update installers and install node
RUN apt-get update \
    && apt-get install -y wget curl unzip \
    && curl -sL https://deb.nodesource.com/setup_22.x | bash \
    && apt-get install -y nodejs

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Install terraform
RUN wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip /tmp/terraform.zip -d /tmp \
    && mv /tmp/terraform /usr/local/bin/ \
    && rm -rf /tmp/*

# Install CDK via npm
RUN npm install -g aws-cdk

ENTRYPOINT ["cdk", "--version"]