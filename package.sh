#!/bin/bash

ZIPFILE=AlexaLambda.zip
REGION=us-west-1
FUNCTION_NAME=alexa-radiospiral
HANDLER=index.handler
EXEC_ROLE=arn:aws:iam::999999999:role/lambda_radiospiral_alexa
RUNTIME=nodejs6.10
ACCOUNT_ID=999999999 # radiospiral
PROFILE=radiospiral

pushd src
# if the ZIP file does exist, just refresh it
if [ -e ../$ZIPFILE ];
then
   REFRESH=-f
fi
zip -j $REFRESH ../$ZIPFILE  *.js
zip $REFRESH ../$ZIPFILE -r node_modules/*
zip $REFRESH ../$ZIPFILE -r utils/*
popd

aws lambda update-function-code                     \
         --profile $PROFILE                         \
         --region $REGION                           \
         --function-name $FUNCTION_NAME             \
         --zip-file fileb://./$ZIPFILE


# to programmatically create Lambda function :

# aws lambda delete-function                        \
#          --profile $PROFILE                       \
#          --region $REGION                         \
#          --function-name $FUNCTION_NAME

# aws lambda create-function                        \
#          --profile $PROFILE                       \
#          --region $REGION                         \
#          --function-name $FUNCTION_NAME           \
#          --runtime $RUNTIME                       \
#          --role $EXEC_ROLE                        \
#          --handler $HANDLER                       \
#          --zip-file fileb://$ZIPFILE              \
#          --memory-size 512                        \
#          --timeout 30                             \
#          --query FunctionArn --output text

# aws lambda add-permission                         \
#             --profile $PROFILE                    \
#             --region $REGION                      \
#             --function-name $FUNCTION_NAME        \
#             --statement-id 1                      \
#             --principal alexa-appkit.amazon.com   \
#             --action lambda:InvokeFunction        \
