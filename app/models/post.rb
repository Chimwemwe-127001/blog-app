class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'users_id'
  has_many :likes
  has_many :comments
  validates :Title, presence: true, length: { maximum: 250 }
  validates :Likes_Counter, :Comments_Counter, numericality: { greater_than_or_equal_to: 0 }

  after_create :update_posts_counter
  after_destroy :update_posts_counter_after_destroy

  def recent_comments
    comments.order('created_at Desc').limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:Posts_Counter)
  end

  def update_posts_counter_after_destroy
    author.decrement!(:Posts_Counter)
  end
end
