#!/usr/bin/env bash
set -euo pipefail
set -x #echo on

#check if stack prefix was provided
if [ $# == 0 ] || [ -z "$0" ]; then
    echo "Invalid stack prefix"
    exit 1
fi



aws cloudformation deploy \
  --region=$AWS_REGION \
  --stack-name="$ECR_STACK_NAME" \
  --template-file=./infra/ecr.yaml \
  --tags=$TAGS \
  --no-fail-on-empty-changeset


aws cloudformation deploy \
  --region=$AWS_REGION \
  --stack-name="$VPC_STACK_NAME" \
  --template-file=./infra/vpc.yaml \
  --capabilities=CAPABILITY_IAM \
  --no-fail-on-empty-changeset


aws cloudformation deploy \
  --region=$AWS_REGION \
  --stack-name="$RDS_STACK_NAME" \
  --template-file=./infra/mysql.yaml \
  --tags=$TAGS \
  --no-fail-on-empty-changeset \
  --parameter-overrides \
  DatabaseName="$DATABASE_NAME" \
  StackName="$VPC_STACK_NAME" \
  SecretName="$RDS_SECRET_NAME"

