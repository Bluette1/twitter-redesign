module UsersHelper
  def user
    @user
  end

  def retrieve_image
    user.photo.url(:thumb)
  end

  def follow_or_unfollow_btn
    if current_user != user && !following?
      follow_btn
    elsif following?
      following_id = following_id user
      unfollow_btn following_id
    end
  end

  def username
    "@#{user.username}"
  end

  def full_name
    user.full_name.to_s
  end

  def follow_btn
    link_to '+/Follow', user_followings_path(user.id), method: :post, class: ' mt-2 follow btn'
  end

  def unfollow_btn(following_id)
    link_to '-/Unfollow', user_following_path(user.id, following_id), method: :delete, class: ' mt-2 follow btn'
  end

  def followers_and_following_count
    "#{@followers_count} Followers     #{@following_count} Following"
  end

  def followers
    @followers
  end

  def cover_image
    user.cover_image.url(:medium)
  end
end
