require 'json'

class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= session[:current_user_id] &&
                      User.find_by(id: session[:current_user_id])
  end

  def trends
    trends = $redis.get('trends')
    if trends.nil?
      trends = Feeder.new.send_feed
      $redis.set('trends', trends.to_json)
      $redis.expire('trends', 1.hour.to_i)
    end

    @trends = JSON.parse trends
  end
end
