require 'rails_helper'
require 'capybara/rspec'

url = 'http://127.0.0.1:3000/'

RSpec.describe 'User Index', type: :feature, js: false do
  before do
    visit url
  end

  describe 'User Index' do
    let!(:users) { User.all }

    it 'should display user name' do
      users.each { |user| expect(page).to have_content user.name }
    end

    it 'should display user photo' do
      users.each { |user| expect(page).to have_css("img[src='#{user.photo}']") }
    end

    it 'should display number of posts for each user' do
      users.each { |user| expect(page).to have_content("Number of posts: #{user.posts.count}") }
    end

    it 'should redirect page to user details when user is clicked' do
      user = User.find_by(name: 'Thomas Heflord')
      click_link user.name
      expect(page).to have_current_path('/users/645')
    end
  end
end
