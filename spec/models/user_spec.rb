require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments).with_foreign_key('user_id') }
    it { should have_many(:likes).with_foreign_key('user_id') }
  end

  describe 'validations' do
    it { should validates_presence_of(:name) }
    it { should validates_presence_of(:photo) }
    it { should validates_numericality_of(:posts_counter).only_integer }
    it { should validates_numericality_of(:posts_counter).greater_than_or_equal_to(0) }
    it { should allow_value(0).for(:posts_counter) }
    it { should_not allow_value(-1).for(:posts_counter) }
  end

  describe 'recent' do
    let(:user) { User.create(name: 'John Doe') }

    it 'should return the most recent posts' do
      old_post = create(:post, user: user, created_at: 1.day.ago)
      recent = create_list(:post, 5, user: user)

      expect(user.recent_posts).to eq(recent_posts.reverse[0..2])
    end
  end
end
