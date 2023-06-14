class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  validates :text, presence: true

  after_save :upadate_comments_counter

  def upadate_comments_counter
    posts.increment!(:comments_counter)
  end
end
  