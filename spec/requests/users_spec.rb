require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('<h1>List of all the users</h1>')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      user = User.create(name: 'John', id: 1)
      get user_path(user, user.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      user = User.create(name: 'John', id: 1)
      get user_path(user, user.id)
      expect(response).to render_template(:show)
    end

    it 'should include correct placeholder' do
      user = User.create(name: 'John', id: 1)
      get user_path(user, user.id)
      expect(response.body).to include('<h1>User with a given ID</h1>')
    end
  end
end
