#!/usr/bin/env bash
set -euo pipefail
set -x #echo on

#check if stack prefix was provided
if [ $# == 0 ] || [ -z "$0" ]; then
    echo "Invalid stack prefix"
    exit 1
fi



## Stage 2, create task defn. and deploy the container in ECS

aws cloudformation deploy \
  --stack-name="$WEB_STACK_NAME" \
  --template-file=./infra/service.yaml \
  --no-fail-on-empty-changeset \
  --parameter-overrides \
  StackName="$VPC_STACK_NAME" \
  DatabaseName=$DATABASE_NAME \
  ServiceName=$1 \
  SecretName="$RDS_SECRET_NAME" \
  BucketName=$LAMBDA_BUCKET \
  ImageUrl="$IMAGE_URL" \
  DesiredCount=$DESIRED_COUNT \
  ContainerCpu=$CONTAINER_CPU \
  ContainerMemory=$CONTAINER_MEMORY \
  ContainerPort=2368