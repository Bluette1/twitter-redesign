require_relative './feeder'
module TrendsHelper
  trends = $redis.get('trends')
  if trends.nil?
    trends = Feeder.new.send_feed
    $redis.set('trends', trends.to_json)
    $redis.expire('trends', 2.hour.to_i)
    JSON.parse trends
  end
end
