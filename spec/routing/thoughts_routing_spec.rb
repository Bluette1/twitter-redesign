require 'rails_helper'

RSpec.describe ThoughtsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/thoughts').to route_to('thoughts#index')
    end

    it 'routes to #create' do
      expect(post: '/thoughts').to route_to('thoughts#create')
    end

    it 'routes to bookmarks#create' do
      expect(post: '/thoughts/1/bookmarks').to route_to(
        controller: 'bookmarks',
        action: 'create',
        thought_id: '1'
      )
    end
  end
end
