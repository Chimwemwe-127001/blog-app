require 'rails_helper'
RSpec.describe 'On Post Index Page', type: :feature do
  before(:each) do
    visit user_session_path
    @chimwemwe = User.create!(Name: 'Chimwemwe',
                              email: 'test@gmail.com',
                              Bio: 'developer',
                              password: 'password',
                              password_confirmation: 'password',
                              Posts_Counter: 0,
                              confirmed_at: Time.now)
    within('#new_user') do
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    @post1 = @chimwemwe.posts.create!(Title: 'post 1', Text: 'My post 1', users_id: @chimwemwe.id, Comments_Counter: 0,
                                      Likes_Counter: 0)
    @post2 = @chimwemwe.posts.create!(Title: 'post 2', Text: 'My post 2', users_id: @chimwemwe.id, Comments_Counter: 0,
                                      Likes_Counter: 0)
    @post3 = @chimwemwe.posts.create!(Title: 'post 3', Text: 'My post 3', users_id: @chimwemwe.id, Comments_Counter: 0,
                                      Likes_Counter: 0)
    @ritta = User.create!(
      Name: 'Ritta', Bio: 'developer', email: 'ritta@gmail.com',
      password: 'ritta1234', password_confirmation: 'ritta1234', confirmed_at: Time.now
    )
    @ritta.comments.create!(Text: 'Nice', post: @post1)
    @ritta.comments.create!(Text: 'Great', post: @post1)
    @ritta.comments.create!(Text: 'Cool', post: @post1)
    visit user_posts_path(@chimwemwe)
  end
  describe 'post' do
    it 'test username' do
      expect(page).to have_content 'Ritta'
    end
    it 'see the number of posts the user has written' do
      expect(page).to have_content 'Number of posts: 3'
    end
    it 'test posts title.' do
      expect(page).to have_content 'post 1'
      expect(page).to have_content 'post 2'
      expect(page).to have_content 'post 3'
    end
    it 'test the posts body.' do
      expect(page).to have_content 'My post 1'
      expect(page).to have_content 'My post 2'
      expect(page).to have_content 'My post 3'
    end
    it 'test the comments on a post.' do
      expect(page).to have_content 'Nice'
      expect(page).to have_content 'Great'
      expect(page).to have_content 'Cool'
    end
    it 'test the number of comments' do
      expect(page).to have_content 'Comments: 3'
    end
    it 'how many likes a post has.' do
      expect(page).to have_content 'Likes: 0'
    end
    it 'when i click post it redirects to post page' do
      click_link 'post 1'
      expect(page).to have_current_path(user_post_path(@chimwemwe, @post1))
    end
  end
end
