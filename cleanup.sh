#!/usr/bin/env bash



### delete all stacks, NOTE: does not really work for rds and ecr in this case because they take long time to delete
###	work around is to watch AWS console and execute this again when previous stack is deleted

# set -euo pipefail
# set -x #echo on

# STACKS=$(aws cloudformation list-stacks --stack-status-filter CREATE_IN_PROGRESS CREATE_COMPLETE ROLLBACK_IN_PROGRESS ROLLBACK_FAILED ROLLBACK_COMPLETE DELETE_IN_PROGRESS DELETE_FAILED UPDATE_IN_PROGRESS UPDATE_COMPLETE_CLEANUP_IN_PROGRESS UPDATE_COMPLETE UPDATE_ROLLBACK_IN_PROGRESS UPDATE_ROLLBACK_FAILED UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS UPDATE_ROLLBACK_COMPLETE REVIEW_IN_PROGRESS --query "StackSummaries[*].StackName" --output text)

# for stack in $STACKS
# do
#     aws cloudformation delete-stack --stack-name $stack
# done