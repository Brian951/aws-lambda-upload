#!/bin/sh -l

if [[ -z "$GITHUB_WORKSPACE" ]]; then
  echo "Set the GITHUB_WORKSPACE env variable."
  exit 1
fi

zipname = site-packages.zip
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2
zip -a $zipname $GITHUB_WORKSPACE 
aws lambda update-funnction-code --function-name $3 --zip-file $zipname