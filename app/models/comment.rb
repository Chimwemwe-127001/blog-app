class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'users_id'
  belongs_to :post

  after_create :update_comments_counter
  after_destroy :update_comments_counter_after_destroy

  private

  def update_comments_counter
    post.increment!(:Comments_Counter)
  end

  def update_comments_counter_after_destroy
    post.decrement!(:Comments_Counter)
  end
end
