require 'capybara/rspec'

RSpec.describe 'New Post Form', type: :feature do
  before do
    @user = User.find_by(name: 'Thomas Heflord')
    visit "http://127.0.0.1:3000/users/#{@user.id}/posts/new.645"
  end

  it 'allows users to create a new post' do
    fill_in 'Post title', with: 'Test Post'
    fill_in 'Your post', with: 'This is a test post'
    click_button 'Save'

    expect(page).to have_content('Test Post')
    expect(page).to have_content('This is a test post')
    expect(page).to have_content('Comments: 0')
    expect(page).to have_content('Likes: 0')
  end
end
