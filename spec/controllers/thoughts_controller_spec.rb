require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe ThoughtsController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in(@user)
    @author_id = @user.id
  end
  describe 'POST create ' do
    let(:thought) { { text: 'text', author_id: @author_id } }
    subject { post :create, params: { thought: thought } }

    it 'redirects to the action show' do
      expect(subject).to redirect_to(thoughts_url)

      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
    end

    it 'sets the correct flash notice' do
      post :create, params: { thought: thought }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq 'Thought was successfully created.'
    end
  end

  describe 'GET index ' do
    before :each do
      @thought = Thought.create(text: 'text', author_id: @author_id)
      @params = { id: @thought.id }
    end

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @thoughts' do
      get :index
      expect(assigns(:thoughts)).to eq([@thought])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
