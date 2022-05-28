#!/usr/bin/env bash
set -euo pipefail
# set -x #echo on

## execute the following scripts with a prefix such as "stack-dev"
## or "stack-prod" or anything meaningful

PREFIX=ghostblog


## the name for the database
export DATABASE_NAME=$PREFIX

## AWS region to deploy in
export AWS_REGION="eu-north-1"

## general stack properties
export TAGS="Project=$PREFIX"

## Stack and othe names
export ECR_STACK_NAME="$PREFIX-ecr"
export VPC_STACK_NAME="$PREFIX-vpc"
export RDS_STACK_NAME="$PREFIX-rds"
export WEB_STACK_NAME="$PREFIX-web"
export LAMBDA_STACK_NAME="$PREFIX-lambda"


export RDS_SECRET_NAME="$PREFIX-RDSSecret"
export LAMBDA_BUCKET="$PREFIX-lambda-bucket"


## stack scaling properties
export DESIRED_COUNT=1
export MAXIMUM_COUNT=2
export CONTAINER_CPU=256
export CONTAINER_MEMORY=512



## with the following script we deploy ECR, VPC, MySQL RDS.

# ./stage_1.sh $PREFIX


## with this script we push an image to be deployed on ECS using Fargate
## we can execute this script again in future to update the image
## ECS will automatically deploy this new image
## ATTENTION: remember to uncomment and fill in proper values in pushimg.sh

# ./pushimg.sh $PREFIX


## url of the image to be deployed
## after executing pushimg.sh you will have an image in AWS ECR
## copy the image name and paste below

# export IMAGE_URL=<name_of_image_to_be_deployed>

## with this script we deploy taskdefinition, ECS service etc.
# ./stage_2.sh $PREFIX


## deploy the lambda function
# ./stage_3.sh $PREFIX


## execute the lambda function
# ./delete-posts-lambda.sh $DATABASE_NAME