## Terraform project to create architecture

### Lambda -> SQS query -> Lambda -> S3
* User send Http with id ->
* Http Lambda handle request and put into SQS query
* Message in SQS trigger Event Lambda
* Event Lambda put message in S3

# Instruction 
1. terraform init
2. terraform plan -out=plan
3. terraform apply "plan"
4. Take link from lambda UI (responsive argument hasn't been found to put in "output")
5. Make Get request with "id" query parameter. (Postman, curl, browser)


## Improved:
- Corrected parameters of query to make it faster (default made too big latency)

## To be improved:
- find argument to output function url **––>** take it from function_url resource :)
- change authorization method to Function Url. Now it's not secure due to easiness
- relative path (question in a code) **––>** [path](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)
- tfvars generator (terraform tfvars exists locally)
