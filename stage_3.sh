#!/usr/bin/env bash
set -euo pipefail
set -x #echo on

#check if stack prefix was provided
if [ $# == 0 ] || [ -z "$0" ]; then
    echo "Invalid stack prefix"
    exit 1
fi


## use a basic nodejs app to execute lambda, install dependencies
cd lib/nodejs && npm install && cd ../../


## transforming template file to use AWS resources, in Lambda function
aws cloudformation package \
    --template-file ./infra/lambda-raw.yaml \
    --s3-bucket $LAMBDA_BUCKET \
    --output-template-file ./infra/lambda-ready.yaml


## now deploying the lambda function
aws cloudformation deploy \
    --stack-name="$LAMBDA_STACK_NAME" \
    --template-file ./infra/lambda-ready.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
    DatabaseName="$DATABASE_NAME" \
    StackName="$VPC_STACK_NAME" \
    SecretName="$RDS_SECRET_NAME"

