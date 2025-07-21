#!/bin/bash

# Push a test image for the test-ecr

set -eu

AWS_ACCOUNT_ID="$1"

ECR_NAME="test-ecr"

# Login
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com"

# Build
docker build -t test-service .

# Tag image for ECR
docker tag test-service:latest "$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_NAME:latest"

# Push image to ECR
docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_NAME:latest
