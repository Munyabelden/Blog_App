require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User').with_foreign_key('user_id') }
    it { should belong_to(:post).class_name('Post').with_foreign_key('post_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:text) }
  end

  describe '#update_comments_counter' do
    let(:post) { create(:post) }
    let!(:comment1) { create(:comment, post: post) }
    let!(:comment2) { create(:comment, post: post) }

    it 'updates the post\'s comments_counter' do
      expect { comment1.update_comments_counter }.to change { post.reload.comments_counter }.by(1)
      expect { comment2.update_comments_counter }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
