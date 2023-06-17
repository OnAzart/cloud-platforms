# Instructions to connect database to the flow
#### ... -> sqs -> Database
1. Create RDS database with Postgres
2. Create EC2 with RDS connect
3. Set up instance 
   - sudo dnf install postgresql15
   - psql --host=<RDS_ENDPOINT> --port=<RDS_PORT> --username=<DB_USERNAME> --password
   - psql --host=first-df.cvxtxzqai9xw.us-east-2.rds.amazonaws.com --port=5432 --username=postgres --password
4. Create table 
   - CREATE TABLE id_table (id VARCHAR(100) PRIMARY KEY);
   - check for existence: *\d id_table*

5. Update runtime with needed libraries:
   - **Locally**:
     - Create zip of libs with [psycopg-binary library](https://awstip.com/example-of-deploying-of-psycopg2-binary-python-package-as-an-aws-lambda-layer-aef4953ed8d4)
   - **AWS**:
     - Create layer, by uploading zip
     - Attach layer to the function
6. Add trigger from SQS
7. Test it and pay attention to logs in CloudWatch


### Main complexities | Things to pay attention
- Connecting to the same VPC. Lambda doesn't have access to the internet by default
- Set up logging to debug it less struggling.  **P.S.** *Logs in cloud are weird!*
- Download **psycopg-binary** by the link, not simple 
