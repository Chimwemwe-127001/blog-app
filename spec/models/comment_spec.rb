require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'add some comments' do
    author = User.new(Name: 'Tom', Photo: 'Tom.png', Bio: 'Bio', Posts_Counter: 0)
    post = Post.new(Title: 'New post', Text: 'Good evening', author: author, Likes_Counter: 0, Comments_Counter: 0)
    post.save!

    comment_creator = User.new(Name: 'Jerry', Photo: 'Tom.png', Bio: 'Bio', Posts_Counter: 0)
    post.comments.create!(Text: 'Hello World', author: comment_creator)
    post.comments.create!(Text: 'This is my second post', author: comment_creator)
    expect(post.comments.length).to eql(2)
  end
end
