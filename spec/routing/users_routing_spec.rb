require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to #new' do
      expect(get: '/users/new').to route_to('users#new')
    end

    it 'routes to #show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/users').to route_to('users#create')
    end

    it 'routes to bookmarks#index' do
      expect(get: '/users/1/bookmarks').to route_to('bookmarks#index', user_id: '1')
    end

    it 'routes to followings#create' do
      expect(post: '/users/1/followings').to route_to('followings#create', user_id: '1')
    end

    it 'routes to followings#destroy' do
      expect(delete: '/users/1/followings/1').to route_to('followings#destroy', user_id: '1', id: '1')
    end
  end
end
