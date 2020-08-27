#!/bin/bash
# install jq
# Variables

THING_NAME="MyCoreDevice"
POLICY_NAME="Core_Devices"
CORE_DEFINITION_ID="582efCore_Devicese12-b05a-409e-9a24-a2ba1bcc4a12"

cd certs
sudo wget -O root.ca.pem https://www.amazontrust.com/repository/AmazonRootCA1.pem

# Create a new device
aws iot create-thing --thing-name $THING_NAME > thing.json
THING_ARN=$(jq '.thingArn' thing.json | tr -d '"')

echo $THING_ARN

# Create keys and certs 
aws iot create-keys-and-certificate \
    --set-as-active \
    --certificate-pem-outfile "myCore.cert.pem" \
    --public-key-outfile "myCore.public.key" \
    --private-key-outfile "myCore.private.key" > cert-output.json

CERT_ARN=$(jq '.certificateArn' cert-output.json | tr -d '"')

echo $CERT_ARN

# Create an IAM policy
aws iot create-policy \
    --policy-name $POLICY_NAME \
    --policy-document "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Action\":[\"iot:Publish\",\"iot:Subscribe\",\"iot:Connect\",\"iot:Receive\"],\"Resource\":[\"*\"]},{\"Effect\":\"Allow\",\"Action\":[\"iot:GetThingShadow\",\"iot:UpdateThingShadow\",\"iot:DeleteThingShadow\"],\"Resource\":[\"*\"]},{\"Effect\":\"Allow\",\"Action\":[\"greengrass:*\"],\"Resource\":[\"*\"]}]}"

# Attach policy to cert

aws iot attach-policy --policy-name $POLICY_NAME --target $CERT_ARN

# Attach thing to cert

aws iot attach-thing-principal --thing-name $THING_NAME --principal $CERT_ARN

# Create the core

aws greengrass create-core-definition \
    --name "MyCores" \
    --initial-version "{\"Cores\":[{\"Id\":\"$THING_NAME\",\"ThingArn\":\"$THING_ARN\",\"CertificateArn\":\"$CERT_ARN\",\"SyncShadow\":true}]}"
