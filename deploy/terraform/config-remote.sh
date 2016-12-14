#!/bin/sh

TF_REMOTE_BACKEND=s3
TF_REMOTE_S3_BUCKET=jhg-tf-remote-state
TF_REMOTE_NAMESPACE=diceware-api
TF_REMOTE_NAME=infrastructure
TF_REMOTE_REGION=us-west-2

if [ -d ".terraform" ]; then
  echo """
    Remote state for this terraform configuration has already been synced.
    Please use "terraform remote" commands to fix your state, or delete the existing state to continue.
    To delete the existing state: rm -rf $(pwd)/.terraform/
  """
  exit 1
fi

terraform remote config \
    -backend=${TF_REMOTE_BACKEND} \
    -backend-config="bucket=${TF_REMOTE_S3_BUCKET}" \
    -backend-config="key=${TF_REMOTE_NAMESPACE}/${TF_REMOTE_NAME}.tfstate" \
    -backend-config="region=${TF_REMOTE_REGION}"