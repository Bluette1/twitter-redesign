require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe FollowingsController, type: :controller do
  before :each do
    @follower = create(:user)
    sign_in(@follower)
    @followed = create(:user, { username: 'followed', full_name: 'followed_name' })
  end

  describe 'POST create ' do
    subject { post :create, params: { user_id: @followed.id } }

    it 'redirects to the action index' do
      expect(subject).to redirect_to(user_url(@followed.id))

      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end

    it 'sets the correct flash notice' do
      post :create, params: { user_id: @followed.id }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq "You are now following #{@followed.username}"
    end
  end

  describe 'DELETE destroy ' do
    let(:following) { Following.create(follower: @follower, followed: @followed) }
    subject { delete :destroy, params: { user_id: @followed.id, id: following.id } }

    it 'redirects to the action show' do
      expect(subject).to redirect_to(user_url(@followed.id))

      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end

    it 'sets the correct flash notice' do
      delete :destroy, params: { user_id: @followed.id, id: following.id }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq "You have successfully unfollowed #{@followed.username}"
    end
  end
end
