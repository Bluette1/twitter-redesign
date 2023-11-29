require_relative './feeder'
require 'json'

module TrendsHelper
  def trends
    trends = $redis.get('trends')

    if trends.nil?
      trends = Feeder.new.send_feed
      $redis.set('trends', trends.to_json)
      $redis.expire('trends', 2.hour.to_i)
    else
      trends = JSON.parse trends
    end
    @trends = trends
  end
end
