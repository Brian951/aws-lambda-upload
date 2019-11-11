#!/bin/sh -l

if [ -z "$GITHUB_WORKSPACE" ]; then
  echo "Set the GITHUB_WORKSPACE env variable."
  exit 1
fi

apt-get update 
apt-get install -y python3 python3-pip  zip
python3 -m pip --no-cache-dir install --upgrade awscli

ZIPNAME="site-packages.zip"
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2
aws configure set default.region $3
zip -r $ZIPNAME $GITHUB_WORKSPACE 
UPLOADNAME="fileb://$ZIPNAME"
aws lambda update-function-code --function-name $4 --zip-file $UPLOADNAME