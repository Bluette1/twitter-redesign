require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe BookmarksController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in(@user)
    @author = create(:user, { username: 'author', full_name: 'author_name' })
    @thought = create(:thought, { author: @author })
  end
  describe 'POST create ' do
    subject { post :create, params: { thought_id: @thought.id, user: @user } }

    it 'redirects to the action index' do
      expect(subject).to redirect_to(user_bookmarks_url(@user.id))

      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end

    it 'sets the correct flash notice' do
      post :create, params: { thought_id: @thought.id, user: @user }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq 'You bookmarked an idea.'
    end
  end

  describe 'DELETE destroy ' do
    let(:bookmark) { Bookmark.create(thought: @thought, user: @user) }
    subject { delete :destroy, params: { user_id: @user.id, id: bookmark.id } }

    it 'redirects to the action show' do
      expect(subject).to redirect_to(user_bookmarks_url(@user.id))

      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end

    it 'sets the correct flash notice' do
      delete :destroy, params: { user_id: @user.id, id: bookmark.id }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq 'You deleted a bookmark.'
    end
  end

  describe 'GET index ' do
    before :each do
      @bookmark = Bookmark.create(thought: @thought, user: @user)
    end

    it 'returns a successful response' do
      get :index, params: { user_id: @user.id }
      expect(response).to be_successful
    end

    it 'assigns @bookmarks' do
      get :index, params: { user_id: @user.id }
      expect(assigns(:bookmarks)).to eq([@bookmark])
    end

    it 'renders the index template' do
      get :index, params: { user_id: @user.id }
      expect(response).to render_template('index')
    end
  end
end
