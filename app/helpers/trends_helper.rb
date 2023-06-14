require_relative './feeder'
module TrendsHelper
  def trends
    session[:trends] ||= Feeder.new.send_feed
    @trends ||= session[:trends]
  end
end
