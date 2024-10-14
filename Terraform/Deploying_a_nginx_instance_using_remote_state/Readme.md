In this project we're going to deploy an nginx server on an AWS EC2 instance, for this example we're impementing a s3 bucket for storage the terraform state , and a DynamoDB table to prevents the multiple files upload at the same time.

To do that we need to install the following tools:

-Terraform
-Tenv
-AWS CLI

After that,link your AWS account with the AWS CLI, by run the following command:

    aws configure
    
Then, provide your AWS Account credentials when prompted: 

    AWS Access Key ID [None]: 
    AWS Secret Access Key [None]: 
    Default region name [None]: example(us-east-1)
    Default output format [None]: example(json)

Once thats done, initialize  Terraform, running the following command:

    terraform init
 
Then we need to follow some steps after apply the Terraform configurations.

First thing we need to do is create an AWS S3 Bucket, to storage the Terraform State file. Copy the following commands, which you can also find by opening the file called dynamodb_table_creation.

    aws dynamodb create-table \
        --table-name terraform_locks \
        --attribute-definitions AttributeName=LockID,AttributeType=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

Ensure the table was create running the following command:

    aws dynamodb list-tables --region us-east-1
    
Then, the second thind we need to do is create a AWS S3 Bucket, to do that you can open your AWS CONSOLE and create a the bucket naming it: *terraform-workshop-nginx*, or run the following command:

aws s3api create-bucket --bucket terraform-workshop-nginx --region us-east-1

Verify if the bucket was create running the following command:

    aws s3 ls
    
Then, apply the Terraform configurations, running the following command:

    terraform apply
    
Type *yes* when prompted, if requierd
    
If everything is correct,the console will display the Instance id, and the public ip of the EC2 instance, then, copy the public ip in a browser. You should see the nginx welcome page.

To destroy all the configuration, run the following command:

    terraform destroy
    
Type *yes* when prompted, if requierd