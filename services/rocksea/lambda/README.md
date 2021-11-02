### Creating a SNS Topic
```
aws sns create-topic --name sns-topic-for-lambda
{
    "TopicArn": "arn:aws:sns:ap-northeast-2:xxxxxxxxxx:sns-topic-for-lambda"
}
```


### Creating a Lambda Function
```
zip function.zip index.js

aws lambda create-function --function-name Function-With-SNS \
--zip-file fileb://function.zip --handler index.handler --runtime nodejs12.x \
--role arn:aws:iam::xxxxxxxxxx:role/lambda-sns-execution-role  \
--timeout 60
--profile account
{
    "FunctionName": "Function-With-SNS",
    "FunctionArn": "arn:aws:lambda:ap-northeast-2:xxxxxxxxxx:function:Function-With-SNS",
    "Runtime": "nodejs12.x",
    "Role": "arn:aws:iam::xxxxxxxxxx:role/lambda-sns-execution-role",
    "Handler": "index.handler",
    "CodeSize": 359,
    "Description": "",
    "Timeout": 60,
    "MemorySize": 128,
    "LastModified": "2021-10-19T17:37:08.828+0000",
    "CodeSha256": "s6NvONEAxHY4fFNU+w04l7YjlciJhrvliTVpmv9oKio=",
    "Version": "$LATEST",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "c78fb5ab-ee9f-4c02-ab21-1620b4d3d15e",
    "State": "Active",
    "LastUpdateStatus": "Successful",
    "PackageType": "Zip"
}

```

### Adding a SNS Permission
```
aws sns add-permission --label lambda-access --aws-account-id xxxxxxxxxx \
--topic-arn arn:aws:sns:ap-northeast-2:xxxxxxxxxx:sns-topic-for-lambda \
--action-name Subscribe ListSubscriptionsByTopic
```


### Adding a SNS Subscribe
```
aws sns subscribe --protocol lambda \
--topic-arn arn:aws:sns:ap-northeast-2:xxxxxxxxxx:sns-topic-for-lambda \
--notification-endpoint arn:aws:lambda:ap-northeast-2:xxxxxxxxxx:function:Function-With-SNS \
{
    "SubscriptionArn": "arn:aws:sns:ap-northeast-2:xxxxxxxxxx:sns-topic-for-lambda:c1e8d1b6-32c7-4d4d-bea7-9262b3f8ea86"
}
```


### Publishing a Message to SNS
```
aws sns publish --message file://message.txt --subject Test \
--topic-arn arn:aws:sns:ap-northeast-2:xxxxxxxxxx:sns-topic-for-lambda \
--profile account
{
    "MessageId": "fa558478-706e-55a1-a85a-dd917647b307"
}
```
