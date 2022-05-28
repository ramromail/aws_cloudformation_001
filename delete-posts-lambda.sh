#!/bin/bash
set -eo pipefail
set -x #echo on


#check if stack prefix was provided
if [ $# == 0 ] || [ -z "$0" ]; then
    echo "Invalid database name"
    exit 1
fi


FUNCTION=$(aws cloudformation describe-stack-resource --stack-name $1 --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)


aws lambda invoke \
  --function-name $FUNCTION \
  --payload file://events/delete_posts.json \
  out.json
