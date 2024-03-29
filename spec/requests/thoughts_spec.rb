require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/thoughts', type: :request do
  let(:mary) do
    { username: 'mary_s', full_name: 'mary s' }
  end

  before(:each) do
    post users_url, params: { user: mary }
  end

  describe 'GET /index' do
    let(:author) { User.find_by(username: mary[:username]) }
    let(:valid_attributes) do
      { text: 'some text', author: }
    end
    it 'renders a successful response' do
      Thought.create! valid_attributes
      get thoughts_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:author) { User.find_by(username: mary[:username]) }
    let(:valid_attributes) do
      { text: 'some text', author: }
    end

    context 'with valid parameters' do
      it 'creates a new Thought' do
        expect do
          post thoughts_url, params: { thought: valid_attributes }
        end.to change(Thought, :count).by(1)
      end

      it 'redirects to the created thought' do
        post thoughts_url, params: { thought: valid_attributes }
        expect(response).to redirect_to(thoughts_url)
      end
    end

    context 'with invalid parameters' do
      let(:author) { User.find_by(username: mary[:username]) }
      let(:invalid_attributes) do
        { text: '', author: }
      end
      it 'does not create a new Thought' do
        expect do
          post thoughts_url, params: { thought: invalid_attributes }
        end.to change(Thought, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post thoughts_url, params: { thought: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
