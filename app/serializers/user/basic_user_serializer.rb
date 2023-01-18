class User::BasicUserSerializer < User::UserSerializer

  attributes :liked

  def liked
    object.likes?(@instance_options[:current_user].id) if @instance_options[:current_user]
  end

end
