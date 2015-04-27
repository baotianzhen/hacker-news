class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  validates :title, :body, presence: true

  def time_since_creation
    ((Time.now - created_at) / 3600).round
  end
end
