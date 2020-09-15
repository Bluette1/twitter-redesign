class FollowingsController < ApplicationController
  before_action :set_user, only: %i[update create destroy]
  before_action :set_following, only: %i[update destroy]

  def create
    following = current_user.followings.build(followed: @user)

    if following.save
      flash[:notice] = "You are now following #{@user.name}"
    else
      flash[:alert] = "An error occurred while trying to follow #{@user.name} #{following.errors.full_messages}"
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
