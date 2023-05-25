require 'rails_helper'

RSpec.describe 'Followings', type: :request do
  let(:mary) do
    { username: 'mary_s', full_name: 'mary s' }
  end

  let(:jane) do
    { username: 'jane_s', full_name: 'jane s' }
  end

  before(:each) do
    post users_url, params: { user: mary }
  end

  describe 'followings#create' do
    let(:follower) { User.find_by(username: mary[:username]) }
    let(:followed) do
      User.create! jane
    end

    it 'a user can follow another user successfully' do
      post user_followings_url(followed.id)
      expect(response).to redirect_to user_path(followed.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq "You are now following #{followed.username}"
      expect(Following.find_by(follower:, followed:)).not_to eq nil
    end
  end

  describe 'followings#destroy' do
    let(:follower) { User.find_by(username: mary[:username]) }
    let(:followed) do
      User.create! jane
    end

    it 'a user can follow another user successfully' do
      following = Following.create(follower:, followed:)
      delete user_following_url(followed.id, following.id)
      expect(response).to redirect_to user_path(followed.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq "You have successfully unfollowed #{followed.username}"
      expect(Following.find_by(follower:, followed:)).to eq nil
    end
  end
end
