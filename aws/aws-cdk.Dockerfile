FROM node:22

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