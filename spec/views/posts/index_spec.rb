require 'capybara/rspec'

RSpec.describe 'User profile page', type: :feature do
  before do
    @user = User.create(name: 'Thomas Heflord',
                        photo: 'https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4=',
                        posts_counter: 5)
    @posts = [
      Post.create(author: @user, title: 'Morality',
                  text: 'Strive for Personal Growth: Embrace personal growth and strive to become the best',
                  comments: []),
      Post.create(author: @user, title: 'Honesty and Integrity',
                  text: 'Practice integrity and honesty in your words and actions. Be true to your principles and',
                  comments: [])
    ]
  end

  it 'displays the user profile information and posts' do
    visit 'http://127.0.0.1:3000/users/645/posts'

    expect(page).to have_selector('h2', text: @user.name)
    expect(page).to have_selector('img[src="https://media.istockphoto.com/id/1289461328/photo/portrait-of-a-handsome-black-man.jpg?s=612x612&w=0&k=20&c=y_mzB0Tbe5LErNy6pqfY7sz2HiDT7fOAUCwupN3-Bg4="]')

    @posts.each do |post|
      expect(page).to have_selector('h3', text: post.title)

      expect(page).to have_selector('.user-count span', text: "Comments: #{post.comments.count}")
      expect(page).to have_selector('.user-count span', text: "Likes: #{post.likes.count}")

      post.comments.each do |comment|
        expect(page).to have_selector('li', text: "#{comment.user.name}: #{comment.text}")
      end
    end
  end
end
