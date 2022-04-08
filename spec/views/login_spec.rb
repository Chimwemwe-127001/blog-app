require 'rails_helper'

RSpec.describe 'Login Page', type: :system do
  describe 'index page' do
    before :all do
      unless User.find_by(email: 'sinyinzachimwemwe@gmail.com')
        user3 = User.new(
          Name: 'Chimwemwe Sinyinza',
          Photo: 'https://images.unsplash.com/photo-1647858881692-cd17fd80cf51?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
          email: 'sinyinzachimwemwe@gmail.com',
          password: '1234567',
          password_confirmation: '1234567',
          role: 'default'
        )
        user3.skip_confirmation!
        user3.save!
      end
    end
    it 'shows the right content' do
      visit user_session_path
      sleep(5)
      click_button 'Log in'
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_button('Log in')
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Forgot your password?')
    end

    it 'Test for wrong input' do
      visit new_user_session_path
      sleep(5)
      within('#new_user') do
        fill_in 'Email', with: 'sinyinzachimwemwe@gmail.com'
        fill_in 'Password', with: '12345678'
      end
      click_button 'Log in'
      expect(page).to have_content('')
    end

    it 'Test for right input' do
      visit new_user_session_path
      sleep(5)
      within('#new_user') do
        fill_in 'Email', with: 'daniel1@hotmail.com'
        fill_in 'Password', with: '123456'
      end
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end
