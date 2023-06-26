require 'rails_helper'
require 'capybara/rspec'

url = 'http://127.0.0.1:3000/'

RSpec.describe 'User Index', type: :feature, js: false do
  user = User.all
end
