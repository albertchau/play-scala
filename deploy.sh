#!/bin/sh
# Copy Dockerfile and Dockerrun.aws.json to target/docker
cp Dockerrun.aws.json target/docker

# Zip the files
cd target/docker
zip -r $GIT_COMMIT.zip *

S3Bucket=elasticbeanstalk-us-west-2-415926896195

# -- AWS --
# Upload the image
aws s3api put-object --bucket ${S3Bucket} --key $GIT_COMMIT --body $GIT_COMMIT.zip

# Create a new application version
aws elasticbeanstalk create-application-version --application-name "play-app" --version-label $GIT_COMMIT --source-bundle S3Bucket=${S3Bucket},S3Key=$GIT_COMMIT

# Deploy the image
aws elasticbeanstalk update-environment --environment-name playApp-env --version-label $GIT_COMMIT
