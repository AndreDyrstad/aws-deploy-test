# Create a function
aws greengrass create-function-definition \
    --name MyGreengrassFunctions \
    --initial-version "{\"Functions\": [{\"Id\": \"TempMonitorFunction\", \"FunctionArn\": \"arn:aws:lambda:us-west-2:123456789012:function:TempMonitor:GG_TempMonitor\", \"FunctionConfiguration\": {\"Executable\": \"temp_monitor.function_handler\", \"MemorySize\": 16000,\"Timeout\": 5}}]}"
