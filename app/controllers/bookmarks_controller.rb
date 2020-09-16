class BookmarksController < ApplicationController

  before_action :set_current_user, only: [:create, :destroy]

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    @bookmark = current_user.bookmarks.new(thought_id: params[:thought_id])

    if @bookmark.save
      redirect_to bookmarks_path, notice: 'You bookmarked an idea.'
    else
      redirect_to bookmarks_path, alert: 'You cannot bookmark this idea.'
    end
  end

  def destroy
    bookmark = Bookmark.find_by(id: params[:id], user: current_user, thought_id: params[:thought_id])
    if bookmark
      bookmark.destroy
      redirect_to bookmarks_path, notice: 'You deleted a bookmark.'
    else
      redirect_to bookmarks_path, alert: 'You cannot delete a bookmark that you did not bookmark before.'
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