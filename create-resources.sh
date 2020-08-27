# Create a resource
aws greengrass create-resource-definition \
    --name MyGreengrassResources \
    --initial-version "{\"Resources\":[]}"
#    --initial-version "{\"Resources\": [{\"Id\": \"TwilioAuthToken\",\"Name\": \"MyTwilioAuthToken\",\"ResourceDataContainer\": {\"SecretsManagerSecretResourceData\": {\"ARN\": \"arn:aws:secretsmanager:us-west-2:123456789012:secret:greengrass-TwilioAuthToken-ntSlp6\"}}}]}"

