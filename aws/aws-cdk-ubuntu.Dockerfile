FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_22.x | bash \
    && apt-get install -y nodejs

# Install dependencies
RUN npm install -g aws-cdk

# Set the working directory (optional, but good practice)
WORKDIR /app

# Copy your CDK code (if applicable)
COPY . .

# You can add other commands here, like installing project dependencies
# RUN npm install  # If your project has dependencies
# RUN npm ci  # If you want to install dependencies from package-lock.json

# You can also set an entrypoint for your container
# ENTRYPOINT ["cdk", "deploy"] # Example: deploy the CDK app on container start
ENTRYPOINT ["cdk", "--version"]