class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :parent, class_name: "Comment"
  has_many :children, class_name: "Comment", foreign_key: :parent_id
  validates :body, presence: :true

  def time_since_creation
    ((Time.now - created_at) / 3600).round
  end
end


