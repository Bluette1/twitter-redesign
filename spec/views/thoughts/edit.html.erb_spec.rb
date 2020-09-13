require 'rails_helper'

RSpec.describe 'thoughts/edit', type: :view do
  before(:each) do
    @thought = assign(:thought, Thought.create!(
                                  text: 'MyText',
                                  author: nil
                                ))
  end

  it 'renders the edit thought form' do
    render

    assert_select 'form[action=?][method=?]', thought_path(@thought), 'post' do
      assert_select 'textarea[name=?]', 'thought[text]'

      assert_select 'input[name=?]', 'thought[author_id]'
    end
  end
end
