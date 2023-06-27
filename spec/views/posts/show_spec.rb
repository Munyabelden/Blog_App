require 'capybara/rspec'

RSpec.describe 'Post Details Section', type: :feature do
  before do
    @user = User.create(name: 'Thomas Heflord')
    @post = Post.create(author: @user, title: 'Morality',
                        text: 'Strive for Personal Growth: Embrace personal growth and strive to become the')
    Comment.create(user: @user, post: @post, text: 'Great lesson for everyone')
    visit 'http://127.0.0.1:3000/users/645/posts/533'
  end

  it 'displays the post details and comments' do
    within('.post-details') do
      expect(page).to have_selector('.user-count span', text: 'Comments: 0')
      expect(page).to have_selector('.user-count span', text: 'Likes: 0')
      expect(page).to have_content('Strive for Personal Growth: Embrace personal growth and strive to become the')
    end

    within('.comment') do
      fill_in 'Enter your comment', with: 'New comment'
      click_button 'Add Comment'
    end

    within('.like') do
      click_button 'Like'
    end
  end
end
