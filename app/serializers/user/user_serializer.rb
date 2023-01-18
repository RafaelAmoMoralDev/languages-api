# Base serializer for the model [User].
class User::UserSerializer < ActiveModel::Serializer

  attributes :id, :name, :email, :phone, :description, :image, :likes

end
