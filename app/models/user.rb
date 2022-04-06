class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'users_id'
  has_many :comments, foreign_key: 'users_id'
  has_many :likes, foreign_key: 'users_id'
  validates :Name, presence: true
  validates :Posts_Counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order('created_at DESC').limit(3)
  end
end
