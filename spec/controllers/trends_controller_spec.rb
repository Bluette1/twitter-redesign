require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe TrendsController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in(@user)
  end

  describe 'GET index ' do

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
