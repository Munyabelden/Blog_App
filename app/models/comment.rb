class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  validates :text, presence: true

  after_save :update_comments_counter

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
