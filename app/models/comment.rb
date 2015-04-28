class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
  has_many :comments, class_name: "Comment", as: :commentable
  validates :body, presence: :true

  def time_since_creation
    ((Time.now - created_at) / 3600).round
  end
end
