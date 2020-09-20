require 'rails_helper'

RSpec.describe 'trends/index', type: :view do
  let(:mary) do
    { username: 'mary_s', full_name: 'mary s' }
  end
  let(:jane) do
    { username: 'jane_s', full_name: 'jane s' }
  end

  before(:each) do
    assign(:trends, [
             { channel: 'channel', title: 'title', link: 'link' },
             { channel: 'other channel', title: 'other title', link: 'other link' }
           ])
    User.create! jane
    User.create! mary

    assign(:who_to_follow, User.all)
  end

  it 'renders a list of trends' do
    render
  end
end
