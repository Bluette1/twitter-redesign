require 'redis-namespace'


$redis=Redis::Namespace.new('twitter_redesign', :redis => Redis.new)