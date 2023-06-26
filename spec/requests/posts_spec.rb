RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/users/645/posts'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users/645/posts'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/645/posts'
      expect(response.body).to include('<h3>Honesty and Integrity</h3>')
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post) }

    it 'returns a successful response' do
      get '/users/645/posts/533'
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get '/users/645/posts/533'
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users/645/posts/533'
      expect(response.body).to include('<h2>Morality by Thomas Heflord</h2>')
    end
  end
end
