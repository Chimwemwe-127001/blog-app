class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'users_id'
  belongs_to :post

  after_create :update_likes_counter

  private

  def update_likes_counter
    post.increment!(:Likes_Counter)
  end
end
