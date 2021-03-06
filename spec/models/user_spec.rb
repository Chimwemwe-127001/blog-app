require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(Name: 'Chimwemwe', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo', Bio: 'Software developer from Zambia')
  end

  before { subject.save }

  it 'Name Should be Present' do
    subject.Name = nil
    expect(subject).to_not be_valid
  end

  it 'Photo should be a string' do
    subject.Photo = 'photo source'
    expect(subject).to be_valid
  end

  it 'Posts counter should be equal or greater than zero' do
    subject.Posts_Counter = -1
    expect(subject).to_not be_valid
  end

  it 'recent posts method should return last three posts' do
    post1 = Post.create(author: subject, Title: 'One', Text: 'first post')
    post2 = Post.create(author: subject, Title: 'Two', Text: 'second post')
    post3 = Post.create(author: subject, Title: 'Three', Text: 'third post')
    post4 = Post.create(author: subject, Title: 'Four', Text: 'fourth post')
    post5 = Post.create(author: subject, Title: 'Five', Text: 'fifth post')
    expect(subject.Posts_Counter).to eq 5
    expect(subject.recent_posts.length).to eq 3
    expect(subject.recent_posts).to include post5, post4, post3
    expect(subject.recent_posts).not_to include post1, post2
  end
end
