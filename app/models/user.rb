class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :name, presence: true, uniqueness: true

  has_secure_password

  has_and_belongs_to_many :users_likes, class_name: 'User', join_table: :users_likes, association_foreign_key: :user1_id, foreign_key: :user2_id,
                          after_add: :update_likes_counter, after_remove: :update_likes_counter

  def self.authenticate(token)
    User.where("REPLACE(REPLACE(SUBSTRING(password_digest, 8, 32), '.', '0'), '/', 'I') = ?", token).limit(1).first
  end

  def token
    self.password_digest[7..38].gsub('.', '0').gsub('/', 'I')
  end

  def likes?(user_id)
    users_like_ids.include?(user_id)
  end

  private

  def update_likes_counter(model)
    self.update(likes: self.users_likes.count)
  end

end
