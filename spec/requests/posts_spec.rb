RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/users/5/posts'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users/5/posts'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/5/posts'
      expect(response.body).to include('<h1>List of all posts</h1>')
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post) }

    it 'returns a successful response' do
      get '/users/5/posts/5'
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get '/users/5/posts/5'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/5/posts/5'
      expect(response.body).to include('<h1>Posts for a given user ID</h1>')
    end
  end
end
