class ConversationSerializer < ActiveModel::Serializer

  attributes :id, :user, :location, :datetime, :created_at, :updated_at

  def datetime
    object.datetime.to_i * 1000
  end

  def created_at
    object.created_at.to_i * 1000
  end

  def updated_at
    object.updated_at.to_i * 1000
  end

  def user
    UserSerializer.new(object.user1.id == @instance_options[:current_user].id ? object.user2 : object.user1, current_user: @instance_options[:current_user])
  end

end
