resource "aws_api_gateway_rest_api" "example-api" {
  name        = "example-api"
  description = "Example API Gateway"
  body = templatefile("${path.module}/../../apps/api-gateway/api.yaml",
    {
      aws_region         = var.AWS_REGION
      example_lambda_arn = aws_lambda_function.example-lambda.arn
      domain_url         = ""
    }
  )

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Name = "example-api-gateway"
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id           = aws_api_gateway_rest_api.example-api.id
  aws_api_gateway_stage = "prod"
}

resource "aws_lambda_permission" "api-gateway-invoke-example-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the specified API Gateway.
  source_arn = "${aws_api_gateway_rest_api.example-api.execution_arn}/*/*"
}
