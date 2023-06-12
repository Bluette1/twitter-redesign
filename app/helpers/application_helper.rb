module ApplicationHelper
  def user_signed_in?
    @current_user
  end

  def current_user
    @current_user
  end

  def bookmarked?(thought)
    current_user.bookmarked?(thought)
  end

  def get_bookmark(thought)
    current_user.get_bookmark(thought)
  end

  def following?
    current_user.following?(@user)
  end

  def following_id(user)
    Following.find_by(follower: current_user.id, followed: user.id).id
  end

  def logged_in_usr
    render 'layouts/profile_and_bookmarks' if user_signed_in?
  end

  def sign_in_and_sign_out
    if user_signed_in?
      render 'layouts/username_logout'
    else
      render 'layouts/sign_in_options'
    end
  end

  def logo_options
    if user_signed_in?
      render 'layouts/logo_star'
    else
      render 'layouts/thoughtstar_logo'
    end
  end

  def retrieve_errors(thought)
    render 'thoughts/errors' if thought.errors.full_messages.any?
  end

  def user_details(user)
    "@#{user.username} #{user.full_name}"
  end

  def usr_id(user)
    user.id
  end

  def bkmark_btn(thought)
    show_bookmark_btn thought if !bookmarked?(thought) && current_user != author(thought)
  end

  def show_bookmark_btn(thought)
    button_to '+/bookmark', thought_bookmarks_path(thought.id), method: :post, class: 'btn btn-primary', type: 'submit'
  end

  def unbkmark_btn(thought)
    show_unbookmark_btn thought if bookmarked?(thought) && current_user != author(thought)
  end

  def show_unbookmark_btn(thought)
    bookmark = get_bookmark(thought)
    button_to '-/bookmark', user_bookmark_path(current_user.id, bookmark.id), method: :delete,
                                                                              class: 'btn btn-primary', type: 'submit'
  end

  def author(thought)
    thought.author
  end

  def id(thought)
    thought.id
  end

  def user_or_author_details(thought)
    user = @user || author(thought)
    link_to user_details(user), user_path(user)
  end

  def user_or_author_img(thought)
    user = @user || author(thought)
    avatar_url(user)
  end

  def avatar_url(user)
    user.photo.url(:thumb)
  end
end
