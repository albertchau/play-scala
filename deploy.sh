#!/bin/sh

S3Bucket=$1
APP_NAME=$2
ENV_NAME=$3

# Copy Dockerfile and Dockerrun.aws.json to target/docker
cp Dockerrun.aws.json target/docker

# Zip the files
cd target/docker
zip -r ${GIT_COMMIT}.zip *

# -- AWS --
# Upload the image
aws s3api put-object --bucket ${S3Bucket} --key ${GIT_COMMIT} --body ${GIT_COMMIT}.zip

# Create a new application version
aws elasticbeanstalk create-application-version --application-name "${APP_NAME}" --version-label ${GIT_COMMIT} --source-bundle S3Bucket=${S3Bucket},S3Key=${GIT_COMMIT}

# Deploy the image
aws elasticbeanstalk update-environment --environment-name ${ENV_NAME} --version-label ${GIT_COMMIT}
