require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before { skip("This still needs to be implemented") }

  let(:author) do
    User.create(username: 'author', full_name: 'Good Author')
  end
  let(:thought_one) do
    Thought.create(text: 'some text', author: author)
  end
  let(:thought_two) do
    Thought.create(text: 'some text', author: author)
  end
  
  before(:each) do
  
    @user = assign(:user, User.create!(
                            username: 'Username',
                            full_name: 'Full Name'
                          ))
   
    assign(:thoughts, [thought_one, thought_two])
  end

  it 'renders attributes in <p>' do
    render
    expect(response).to render_template('users/new')
    
  end
end
