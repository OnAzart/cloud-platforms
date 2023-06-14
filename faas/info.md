1. HttpFunction was used to put message into SQS
Function URL was used to trigger it (alternative to API Gateway but related to current Lambda and not billable separately)
2. EventToS3 function was used to put data to S3 triggered on a writing to SQS 

Everything was done via UI without automating. Planned to be done as a next step.
