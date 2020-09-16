module ApplicationHelper
  def user_signed_in?
    @current_user
  end

  def current_user
    @current_user
  end

  def not_bookmarked thought
    current_user.not_bookmarked?(thought)
  end 

  def following?
    current_user.following?(@user)
  end
  

end
