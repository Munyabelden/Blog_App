require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User').with_foreign_key('user_id') }
    it { should belong_to(:post).class_name('Post').with_foreign_key('post_id') }
  end

  describe '#update_likes_counter' do
    let(:post) { create(:post) }
    let(:user) { create(:user) }
    let!(:like) { create(:like, post: post, user: user) }

    it 'increments the post\'s likes_counter' do
      expect { like.update_likes_counter }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
