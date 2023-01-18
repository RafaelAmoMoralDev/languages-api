class User::AuthenticatedUserSerializer < User::UserSerializer

  attributes :auth_token

  def auth_token
    object.password_digest
  end

end
