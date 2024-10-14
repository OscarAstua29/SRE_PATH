In this project we're going to deploy an nginx server on an AWS EC2 instance, to do that we need to install the following tools:

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

Once thats done, initialize the Terraform, running the following command:

    terraform init
    
then, to apply the Terraform configurations, by running the following command:

    terraform apply
    
If everything is correct,the console will display the Instance id, and the public ip of the EC2 instance, then, copy the public ip in a browser. You should see the nginx welcome page.

To remove all the changes you just did, run the following command:

    terraform destroy

Note: Before initiating or destroying a resourses,for security confirmation, review the terraform configurations, then when prompted in the console type yes.
