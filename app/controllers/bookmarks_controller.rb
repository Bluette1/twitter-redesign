class BookmarksController < ApplicationController

  before_action :set_current_user, only: [:destroy]
  before_action :set_current_user, only: [:create, :destroy, :index]

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @bookmark = current_user.bookmarks.build(thought_id: params[:thought_id])

    if @bookmark.save
      flash[:notice] = "You bookmarked an idea."
      redirect_to user_bookmarks_path(current_user)
    else
      flash[:alert] ="You cannot bookmark this idea. #{@bookmark.errors.full_messages}"
      redirect_to user_bookmarks_path(current_user)
    end
  end

  def destroy
    bookmark = Bookmark.find_by(id: params[:id], user: current_user, thought_id: params[:thought_id])
    if bookmark
      bookmark.destroy
      redirect_to user_bookmarks_path(current_user), notice: 'You deleted a bookmark.'
    else
      redirect_to user_bookmarks_path(current_user), alert: 'You cannot delete a bookmark that you did not bookmark before.'
    end
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