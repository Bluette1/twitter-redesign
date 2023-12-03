require_relative './feeder'

class TrendsWorker
  include Sidekiq::Worker

  def perform(*_args)
    trends = Feeder.new.send_feed
    p 'Fetching trends--------------------'
    $redis.set('trends', trends.to_json)
    $redis.expire('trends', 5.day.to_i)
  end
end
