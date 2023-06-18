## Used [Pricing Calculator](https://calculator.aws/)
Estimated cost for 10_000_000 requests, due to that lower values are covered by Free tier.

All services were added to estimate. 
The biggest estimated cost are for storage. (Object storage and Database)
The next one major cost is for 3 Functions, cost is based on the duration and memory used.

**In general, estimated cost for month, including free tier is approximately 123$** 

---
Key for **reducing cost** is optimising:
- time and memory consumption for Lambda
- file size for s3

The right choice of certain size of resources is one of the most important things in reducing cost.

---
Each one single parameter have different impact on the cost.
For lambda, increasing duration impact the most significantly on price.
For sqs, number of messages impact linear.

Thus, each service should be discovered separately