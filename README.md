# aws-cognito
Web server with Cognito

## Requirements
- Terraform v1.7.5
- provider registry.terraform.io/hashicorp/aws v5.41.0


## Technologies stack
### Cloud
* AWS Cognito
* AWS Api Gateway
* AWS Lambda
* AWS S3
* AWS CloudFront

### Client
* React


## Project deployment
### AWS Setup
#### AWS User and Role
Create AWS user that will be used for access S3 and EC2. For this user create S3 role with `AmazonS3FullAccess`

#### S3 bucket
Create S3 bucket with public access.
Block public access Off.

### Environment variables and GitHub secrets
#### GutHub Actions Secrets
- `AWS_ACCESS_KEY_ID` - register AWS user and generate access key, put in this secret key ID;
- `AWS_SECRET_ACCESS_KEY` - register AWS user and generate access secret;

#### GutHub Actions Variables
- `APP_BASE_URL` - specify AWS CloudFront URL;
- `SERVER_BASE_URL` - specify AWS API gateway URL;
- `COGNITO_CLIENT_ID` - AWS Cognito client ID;
- `USER_POOL_ID` - AWS Cognito User pool ID;
- `S3_BUCKET` - S3 bucket name, for website `prod-static-website-cognito-app-yz`
- `AWS_REGION` - AWS region name `us-east-1`


### Terraform deployment
#### Requirements
- Created AWS account
- Created user with admin rights and downloaded AWS access key for this user `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
- The `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` should be stored in the GitHub secrets

#### Instructions
- Create any pull request in GutHub
- Comment in pull request `/plan prod`, where `/plan` is the action for terraform and `prod` in workspace
- Check GitHub actions and in case no issues detected proceed with the next step
- Comment in pull request `/apply prod`, where `/apply` is the action for terraform and `prod` in workspace
- Check GitHub action result for errors


### Client deployment
- to build and deploy client just create branch `deploy-client` and push it with force update flag;
