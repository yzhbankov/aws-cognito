resource "aws_cognito_user_pool" "cognito_pool" {
  name = "cognito-user-pool"
}

resource "aws_cognito_user_pool_client" "cognito_pool_client" {
  name                                 = "cognito-client"
  user_pool_id                         = aws_cognito_user_pool.cognito_pool.id
  generate_secret                      = false
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "phone"]
  allowed_oauth_flows_user_pool_client = true

  # Replace with the actual CloudFront URL
  callback_urls = [
    "https://${aws_cloudfront_distribution.cdn.domain_name}"
  ]

  logout_urls = [
    "https://${aws_cloudfront_distribution.cdn.domain_name}"
  ]
}

resource "null_resource" "cognito_dependency" {
  depends_on = [
    aws_cognito_user_pool.cognito_pool,
    aws_cognito_user_pool_client.cognito_pool_client
  ]
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.cognito_pool.id
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.cognito_pool_client.id
}
