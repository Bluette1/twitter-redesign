require_relative './feeder'

class TrendsWorker
  include Sidekiq::Worker

  def perform(*args)
    trends = Feeder.new.send_feed
    p "Fetching trends--------------------"
    $redis.set('trends', trends.to_json)
    $redis.expire('trends', 2.hour.to_i)
  end
end
