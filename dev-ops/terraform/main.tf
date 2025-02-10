locals {
  example-lambda = "${path.module}/../../apps/lambdas/example"
  lambda_timeout = 60
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "iam_for_lambda" {
  name               = "${terraform.workspace}_iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_role_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_logs_role_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# EXAMPLE LAMBDA
resource "null_resource" "install_example_dependencies" {
  provisioner "local-exec" {
    command = "cd ${local.example-lambda} && npm install"
  }

  triggers = {
    always_run = timestamp()
  }
}

data "archive_file" "example-lambda" {
  type        = "zip"
  source_dir  = local.example-lambda
  output_path = "/tmp/example-lambda.zip"

  depends_on = [null_resource.install_example_dependencies]
}

resource "aws_lambda_function" "example-lambda" {
  function_name    = "${terraform.workspace}-example-lambda"
  role             = aws_iam_role.iam_for_lambda.arn
  filename         = data.archive_file.example-lambda.output_path
  handler          = "index.handler"
  source_code_hash = data.archive_file.example-lambda.output_base64sha256
  runtime          = "nodejs20.x"
  timeout          = local.lambda_timeout

  environment {
    variables = {
      ENVIRONMENT          = terraform.workspace
      COGNITO_USER_POOL_ID = "us-east-1_v9CP7to1V",
    }
  }
}
