class FollowingsController < ApplicationController
  before_action :set_user, only: %i[update create destroy]
  before_action :set_following, only: %i[destroy]
  before_action :set_current_user, only: %i[destroy create]

  def create
    following = current_user.followings_as_follower.build(followed: @user)

    if following.save
      flash[:notice] = "You are now following #{@user.username}"
    else
      flash[:alert] = "An error occurred while trying to follow #{@user.username} #{following.errors.full_messages}"
    end

    redirect_to user_path(@user.id)
  end

  def destroy
    if @following.destroy
      flash[:notice] = "You have successfully unfollowed #{@user.name}"
    else
      flash[:alert] = "An error occurred while trying to unfollow #{@user.name} #{@user.errors.full_messages}"
    end

    redirect_to user_path(@user.id)
  end
end

private

def set_user
  @user = User.find(params[:user_id])
end

def set_following
  @following = Following.find(params[:id])
end

def set_current_user
    if current_user.nil?
      session[:previous_url] = request.fullpath unless request.fullpath =~ Regexp.new('/user/')
      redirect_to sign_in_path
    end
    @current_user = current_user
end
