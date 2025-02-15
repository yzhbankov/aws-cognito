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
  mfa_configuration = "OPTIONAL"
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
  allowed_oauth_scopes = ["email", "openid", "profile"]

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
