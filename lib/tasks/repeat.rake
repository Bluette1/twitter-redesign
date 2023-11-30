require_relative '../../app/helpers/feeder'

namespace :repeat do
  desc 'Repeat fetching of trends'
  task fetch_trends: :environment do
    trends = $redis.get('trends')
    if trends.nil?
      trends = Feeder.new.send_feed
      $redis.set('trends', trends.to_json)
      $redis.expire('trends', 1.hour.to_i)
    end
  end
end
