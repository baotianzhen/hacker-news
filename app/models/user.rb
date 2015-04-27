class User < ActiveRecord::Base
  has_many :posts, foreign_key: :author_id

  validates :first_name,

  has_secure_password
end
