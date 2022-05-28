#!/usr/bin/env bash
set -euo pipefail
set -x #echo on



##########################################################
## Pull the commands in this section from the AWS Console
## Goto AWS > ECR > View push commands button
##########################################################

## Log into AWS ECR inside Docker
# aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin <ECR ARN>

## Build the docker image
# docker build -t ghostblog-ecr .

## Tag the image with the repo
# docker tag ghost-on-aws-ecr:latest <ECR ARN>/ghost-on-aws-ecr:latest

## Push tag to AWS ECR
# docker push <ECR ARN>/ghost-on-aws-ecr:latest


##########################################################
## Below this part is only needed when updating image
##########################################################

## the ECS serive name here
# SERVICE=$1

# ECS_CLUSTER="<ECS CLUSTER ARN>"

## Force ECS to update 

# aws ecs update-service --cluster "$ECS_CLUSTER" --service "$SERVICE" --force-new-deployment