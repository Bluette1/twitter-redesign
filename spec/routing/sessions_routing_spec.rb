require 'rails_helper'

RSpec.describe SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to users#new' do
      expect(get: '/sign_up').to route_to('users#new')
    end

    it 'routes to sessions#new' do
      expect(get: '/sign_in').to route_to('sessions#new')
    end

    it 'routes to sessions#create' do
      expect(post: '/sign_in').to route_to('sessions#create')
    end

    it 'routes to sessions#destroy' do
      expect(delete: '/sign_out').to route_to('sessions#destroy')
    end
  end
end
