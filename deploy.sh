#!/bin/sh
# Copy Dockerfile and Dockerrun.aws.json to target/docker
cp Dockerrun.aws.json target/docker

# Zip the files
cd target/docker
zip -r $GIT_COMMIT.zip *

# -- AWS --
# Upload the image
aws s3api put-object --bucket test-deploy-ebs --key $GIT_COMMIT --body $GIT_COMMIT.zip

# Create a new application version
aws elasticbeanstalk create-application-version --application-name "play-app" --version-label $GIT_COMMIT --source-bundle S3Bucket=test-deploy-ebs,S3Key=$GIT_COMMIT

# Deploy the image
aws elasticbeanstalk update-environment --environment-name playApp-env --version-label $GIT_COMMIT

Alberts-MBP:docker achau$ history 20
  509  cd ..
  510   cd..
  511  ll
  512  sbt docker:stage
  513  cd ..
  514  ll
  515  sbt docker:stage
  516  cp Dockerrun.aws.json target/docker
  517  cd target/docker
  518  GIT_COMMIT=39jdf94
  519  zip -r $GIT_COMMIT.zip *
  520  ll
  521  rm play-scala.zip 39jdf94.zip
  522  zip -r $GIT_COMMIT.zip *
  523  ll
  524  aws s3api put-object --bucket test-deploy-ebs --key $GIT_COMMIT --body $GIT_COMMIT.zip
  525  aws elasticbeanstalk create-application-version --application-name "play-app" --version-label $GIT_COMMIT --source-bundle S3Bucket=test-deploy-ebs,S3Key=$GIT_COMMIT
  526  aws elasticbeanstalk update-environment --environment-name playApp-env --version-label $GIT_COMMIT
  527  history 10
  528  history 20
Alberts-MBP:docker achau$
