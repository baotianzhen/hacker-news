class User < ActiveRecord::Base
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :username,   presence: true, uniqueness: true
  validates :email,      presence: true, uniqueness: true
  validates :password,   presence: true, length: { minimum: 6 }

  has_secure_password
end
