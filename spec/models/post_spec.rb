require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post model' do
    user = User.create(Name: 'Somdotta', Bio: 'bio')
    subject do
      Post.new(Title: 'New post', Text: 'Hi there', author: user)
    end
    before { subject.save }

    it 'check if the title is not blank' do
      subject.Title = nil
      expect(subject).to_not be_valid
    end

    it 'check if the title is not exceeding 250 characters' do
      subject.Title = 'Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world
      Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello
      world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world'
      expect(subject).to_not be_valid
    end

    it 'validates that likes counter is greater than or equal to 0' do
      subject.Likes_Counter = -1
      expect(subject).to_not be_valid
    end

    it 'loads only the recent 5 comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end
  end
end
