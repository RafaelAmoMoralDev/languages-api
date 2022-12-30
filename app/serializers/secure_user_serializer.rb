class SecureUserSerializer < UserSerializer

  attributes :auth_token

  def auth_token
    object.password_digest
  end

end
