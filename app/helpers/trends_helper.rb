require_relative './feeder'
module TrendsHelper
    def trends
      Feeder.new.send_feed
    end
end
