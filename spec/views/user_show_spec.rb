require 'rails_helper'

RSpec.describe 'Show User page', type: :system do
  describe 'show user page' do
    before :all do
      unless User.find_by(email: 'chimwemwe@gmail.com')
        @user = User.new(Name: 'Chimwemwe',
                         email: 'chimwemwe@gmail.com',
                         Bio: 'Software Developer from Zambia',
                         password: 'password',
                         password_confirmation: 'password',
                         Posts_Counter: 0)
        @user.skip_confirmation!
        @user.save!
        @post1 = Post.create(Title: 'post 1', Text: 'My first post', author: @user, Comments_Counter: 0,
                             Likes_Counter: 0)
        @post2 = Post.create(Title: 'post 2', Text: 'My second post', author: @user, Comments_Counter: 0,
                             Likes_Counter: 0)
        @post3 = Post.create(Title: 'post 3', Text: 'My third post', author: @user, Comments_Counter: 0,
                             Likes_Counter: 0)

        @comment1 = Comment.create(Text: 'My comment', author: @user, post_id: @post1.id)
      end
    end

    it 'render the user name and the Bio' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'chimwemwe@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find_all('h1')
      name[2].click
      expect(page).to have_content('Chimwemwe')
      expect(page).to have_content('Software Developer from Zambia')
    end

    it 'shows the number of posts' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'chimwemwe@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find_all('h1')
      name[2].click
      expect(page).to have_content('Number of posts: 3')
    end

    it 'redirects to the correct path' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'chimwemwe@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find_all('h1')
      name[2].click

      expect(page).to have_current_path('/users/18')
    end

    it 'show the 3 first posts and view all posts button' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'chimwemwe@gmail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      name = find_all('h1')
      name[2].click
      expect(page).to have_content('post 1')
      expect(page).to have_content('post 2')
      expect(page).to have_content('post 3')
      expect(page).to have_button('See all Posts')
    end
  end
end
