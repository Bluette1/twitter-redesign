require 'rails_helper'

RSpec.describe "thoughts/new", type: :view do
  before(:each) do
    assign(:thought, Thought.new(
      text: "MyText",
      author: nil
    ))
  end

  it "renders new thought form" do
    render

    assert_select "form[action=?][method=?]", thoughts_path, "post" do

      assert_select "textarea[name=?]", "thought[text]"

      assert_select "input[name=?]", "thought[author_id]"
    end
  end
end
