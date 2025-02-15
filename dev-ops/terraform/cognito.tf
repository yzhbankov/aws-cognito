resource "aws_cognito_user_pool" "cognito_pool" {
  name = "cognito-user-pool"

  # Sign-in preferences
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
  }
}

resource "aws_cognito_user_pool_client" "cognito_pool_client" {
  name                         = "cognito-client"
  user_pool_id                 = aws_cognito_user_pool.cognito_pool.id
  generate_secret              = false
  supported_identity_providers = ["COGNITO"]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = [
    "code" # Code flow can be used if authorization code is needed
  ]
  allowed_oauth_scopes = ["email", "openid", "phone"]

  # Authentication flows
  explicit_auth_flows = [
    "ALLOW_USER_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  callback_urls = [
    "https://${aws_cloudfront_distribution.cdn.domain_name}"
  ]

  # **Advanced Authentication Settings**
  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }

  access_token_validity  = 1
  id_token_validity      = 1
  refresh_token_validity = 5

  # **Enable Token Revocation**
  enable_token_revocation = true

  # **Prevent User Existence Errors**
  prevent_user_existence_errors = "ENABLED"
}

# Domain for Cognito User Pool
resource "aws_cognito_user_pool_domain" "cognito_domain" {
  domain       = "cognito-user-pool-domain-example" # Replace this with your preferred domain prefix
  user_pool_id = aws_cognito_user_pool.cognito_pool.id
}

resource "null_resource" "cognito_dependency" {
  depends_on = [
    aws_cognito_user_pool.cognito_pool,
    aws_cognito_user_pool_client.cognito_pool_client,
    aws_cognito_user_pool_domain.cognito_domain
  ]
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.cognito_pool.id
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.cognito_pool_client.id
}

output "cognito_user_pool_login_url" {
  value = "https://${aws_cognito_user_pool_domain.cognito_domain.domain}.auth.${var.AWS_REGION}.amazoncognito.com/login?client_id=${aws_cognito_user_pool_client.cognito_pool_client.id}&response_type=code&scope=email%20openid%20phone&redirect_uri=https://${aws_cloudfront_distribution.cdn.domain_name}"
}
