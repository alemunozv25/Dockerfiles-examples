FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y curl unzip

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Set the entrypoint to the AWS CLI
ENTRYPOINT ["aws", "--version"]