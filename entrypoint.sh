#!/bin/sh -l

if [ -z "$GITHUB_WORKSPACE" ]; then
  echo "Set the GITHUB_WORKSPACE env variable."
  exit 1
fi

apt-get zip
python3 -m pip --no-cache-dir install --upgrade awscli

ZIPNAME="site-packages.zip"

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export AWS_DEFAULT_REGION=$3
cd $GITHUB_WORKSPACE 
zip -r $ZIPNAME .
UPLOADNAME="fileb://$ZIPNAME"
./aws.sh lambda update-function-code --function-name $4 --zip-file $UPLOADNAME