require 'rails_helper'

RSpec.describe 'thoughts/index', type: :view do
  before { skip('This still needs to be implemented') }
  before(:each) do
    assign(:thoughts, [
             Thought.create!(
               text: 'MyText',
               author: nil
             ),
             Thought.create!(
               text: 'MyText',
               author: nil
             )
           ])
  end

  it 'renders a list of thoughts' do
    render
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
