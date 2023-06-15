require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
    it { should have_many(:likes).with_foreign_key('post_id') }
    it { should have_many(:comments).with_foreign_key('post_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:text) }
    it do
      should validate_numericality_of(:likes_counter)
        .only_integer
        .is_greater_than_or_equal_to(0)
        .with_message('must be an integer greater than or equal to zero')
        .on(:create)
    end
    it do
      should validate_numericality_of(:comments_counter)
        .only_integer
        .is_greater_than_or_equal_to(0)
        .with_message('must be an integer greater than or equal to zero')
        .on(:create)
    end
  end

  describe '#recent_comments' do
    let(:post) { create(:post) }
    let!(:comment1) { create(:comment, post: post, created_at: 2.hours.ago) }
    let!(:comment2) { create(:comment, post: post, created_at: 1.hour.ago) }
    let!(:comment3) { create(:comment, post: post, created_at: 3.hours.ago) }
    let!(:comment4) { create(:comment, post: post, created_at: 4.hours.ago) }
    let!(:comment5) { create(:comment, post: post, created_at: 5.hours.ago) }
    let!(:comment6) { create(:comment, post: post, created_at: 6.hours.ago) }

    it 'returns the 5 most recent comments' do
      expect(post.recent_comments).to eq([comment2, comment1, comment3, comment4, comment5])
    end
  end

  describe '#update_post_counter' do
    let(:author) { create(:user) }
    let(:post) { create(:post, author: author) }

    it 'increments the author\'s posts_counter' do
      expect { post.update_post_counter }.to change { author.reload.posts_counter }.by(1)
    end
  end
end
