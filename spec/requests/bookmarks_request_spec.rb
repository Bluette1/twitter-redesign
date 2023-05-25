require 'rails_helper'

RSpec.describe 'Bookmarks', type: :request do
  let(:mary) do
    { username: 'mary_s', full_name: 'mary s' }
  end

  let(:jane) do
    { username: 'jane_s', full_name: 'jane s' }
  end

  before(:each) do
    post users_url, params: { user: mary }
  end

  describe 'GET /index' do
    let(:user) { User.find_by(username: mary[:username]) }
    let(:author) do
      User.create! jane
    end
    let(:thought) do
      Thought.create!({ text: 'some text', author: })
    end
    let(:valid_attributes) do
      { user_id: user.id, thought: }
    end

    it 'renders a successful response' do
      Bookmark.create! valid_attributes
      get user_bookmarks_url(user.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:user) { User.find_by(username: mary[:username]) }
    let(:author) do
      User.create! jane
    end
    let(:thought) do
      Thought.create({ text: 'some text', author: })
    end

    context 'with valid parameters' do
      it 'creates a new Bookmark' do
        expect do
          post thought_bookmarks_url(thought.id)
        end.to change(Bookmark, :count).by(1)
      end

      it 'redirects to the bookmarks page' do
        post thought_bookmarks_url(thought.id)
        expect(response).to redirect_to(user_bookmarks_url(user.id))
      end
    end

    context 'with invalid parameters' do
      let(:user) { User.find_by(username: mary[:username]) }
      let(:author) do
        User.create! jane
      end
      let(:thought) do
        Thought.create({ text: 'some text', author: })
      end

      it 'does not create a new Bookmark' do
        expect do
          post thought_bookmarks_url('unknown id')
        end.to change(Bookmark, :count).by(0)
      end

      it 'redirects to the bookmarks page' do
        post thought_bookmarks_url('unknown id')
        expect(response).to redirect_to user_bookmarks_url(user.id)
        expect(response).to have_http_status(:found)
        expect(response).to have_http_status(302)
      end
    end
  end
end
