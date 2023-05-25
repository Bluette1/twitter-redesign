require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe SessionsController, type: :controller do
  let(:params) { { username: 'username', full_name: 'full name' } }

  describe 'POST create ' do
    before :each do
      User.create(params)
    end

    it 'logs in successfully and redirects to the show' do
      post(:create, params:)

      expect(response).to redirect_to(user_url(assigns(:user).id))
      expect(response).to redirect_to("/users/#{assigns(:user).id}")
      expect(flash[:notice]).to eq 'You have successfully logged in'
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end

    it ' fails to log in and renders new' do
      post :create, params: { username: 'different name' }

      expect(flash[:alert]).to eq 'Wrong name. Sign up or enter the correct name'
      expect(response).to render_template('new')
    end
  end

  describe 'POST destroy ' do
    before :each do
      User.create(params)
    end
    subject { post :create, params: }

    it 'successfully logs out user' do
      post(:destroy, params:)
      expect(flash[:notice]).to eq 'You have successfully logged out.'
    end
  end
end
