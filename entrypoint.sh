#!/bin/sh -l

if [ -z "$GITHUB_WORKSPACE" ]; then
  echo "Set the GITHUB_WORKSPACE env variable."
  exit 1
fi

ZIPNAME="site-packages.zip"
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2
zip -r $ZIPNAME $GITHUB_WORKSPACE 
UPLOADNAME="fileb://$ZIPNAME"
aws lambda update-function-code --function-name $3 --zip-file $UPLOADNAME