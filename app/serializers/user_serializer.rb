class UserSerializer < ActiveModel::Serializer

  attributes :id, :name, :email, :phone, :description, :image, :likes, :liked

  def liked
    object.likes?(@instance_options[:current_user].id) if @instance_options[:current_user]
  end

end
