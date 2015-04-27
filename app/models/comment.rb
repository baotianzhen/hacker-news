class Comment < ActiveRecord::Base
  has_many :children, class_name: "Comment", foreign_key: :parent_id
  belongs_to :parent, class_name: "Comment"

  validates :body, presence: :true

  def time_since_creation
    ((Time.now - created_at) / 3600).round
  end
end


