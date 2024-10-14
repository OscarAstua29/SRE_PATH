#This script creates a DynamoDB table in AWS and prevents multiple files upload at the same time

#imperative way
aws dynamodb create-table --table-name dynamo_table_name
--attribute-definitiosns attributeName=LockID,AttributeType=S
--key-schema AttribtuteNme=LockID,KeyType=hash_key
--provisioned-throughput ReadCpacityUnits=5,WriteCapacityUnists=5


#declarative way
resource "aws_dynamodb_table" "terraform_locks" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED" #Provisioned mode, it means you need to add w/r parameters

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"

    read_capacity  = 5
    write_capacity = 5
  
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  
}