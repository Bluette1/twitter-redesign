class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= session[:current_user_id] &&
                      User.find_by(id: session[:current_user_id])
  end

  def trends
    session[:trends] ||= Feeder.new.send_feed
    @trends ||= session[:trends]
  end
end
