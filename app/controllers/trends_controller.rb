# require_relative '../helpers/feed_messenger'

class TrendsController < ApplicationController
  include TrendsHelper
  before_action :set_current_user, only: %i[index]

  # GET /trends
  def index
    @trends = trends
    @who_to_follow = @current_user.not_followed
  end
end

private

def set_current_user
  if current_user.nil?
    session[:previous_url] = request.fullpath unless request.fullpath =~ Regexp.new('/user/')
    redirect_to sign_in_path
  end
  @current_user = current_user
end
