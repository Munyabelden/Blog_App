require 'rails_helper'
require 'capybara/rspec'

url = 'http://127.0.0.1:3000/'

RSpec.describe 'show', type: :feature, js: false do
  let(:user) { User.create(name: 'Thomas Heflord', photo: 'https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=', bio: 'Hey there! I am a passionate man in my 30s who finds joy in hiking, working') }

  let!(:post) do
    Post.create(author_id: user.id, title: ' Morality',
                text: 'Strive for Personal Growth: Embrace personal growth and strive to become the best version')
  end

  let!(:post2) do
    Post.create(author_id: user.id, title: 'Honesty and Integrity',
                text: 'Practice integrity and honesty in your words and actions.')
  end

  let!(:post3) do
    Post.create(author_id: user.id, title: 'Consider Consequences:',
                text: 'Think about the potential consequences of your actions.')
  end

  let!(:post4) do
    Post.create(author_id: user.id, title: 'The Road Not Taken',
                text: 'Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler,')
  end

  before(:each) do
    visit "#{url}/users/645"
  end

  describe 'show page' do
    it 'shows the name and profile photo of user' do
      User.find_by(photo: 'https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=')
      expect(page).to have_css("img[src*='https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=']")
      expect(page).to have_content(user.name)
    end

    it 'displays the number of post for a user' do
      User.find_by(name: 'Thomas Heflord')
      expect(page).to have_content('4')
    end

    it 'displays bio for a user' do
      User.find_by(bio: 'Hey there! I am a passionate man in my 30s who finds joy in hiking, working')
      expect(page).to have_content('Hey there! I am a passionate man in my 30s who finds joy in hiking, working')
    end

    it "redirects me to the post's show page when i click a user's post" do
      User.find_by(name: 'Thomas Heflord')
      Post.find_by(text: 'Strive for Personal Growth: Embrace personal growth and strive to become the best versio')
      click_on 'post'
      expect(page).to have_current_path("#{url}users/645/posts")
    end

    it 'should have a button to see all posts' do
      User.find_by(name: 'Thomas Heflord')
      expect(page).to have_link('See all posts')
    end
  end
end
