require 'rails_helper'

RSpec.describe "thoughts/show", type: :view do
  before(:each) do
    @thought = assign(:thought, Thought.create!(
      text: "MyText",
      author: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
