#!/bin/bash

# Push a test image for the test-ecr

set -eu

# Name of the service image
IMAGE_NAME="test-service"
# Output from the terraform module
ECR_NAME="test-service-ecr"
# Region in use
REGION="us-east-1"

# Build
docker build -t $IMAGE_NAME .

# Get AWS account ID
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

# Login
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"

# Tag image for ECR
docker tag $IMAGE_NAME:latest "$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_NAME:latest"

# Push image to ECR
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_NAME:latest"
