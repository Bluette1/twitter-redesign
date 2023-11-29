class TrendsController < ApplicationController
  include TrendsHelper
  def index
    @trends = trends
    @who_to_follow = if @current_user.nil?
                       User.all.first(5)
                     else
                       @current_user.not_followed
                     end
  end
end
