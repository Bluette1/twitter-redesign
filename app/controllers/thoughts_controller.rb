class ThoughtsController < ApplicationController
  before_action :set_current_user, only: %i[create]

  def index
    @thought = Thought.new
    if current_user.nil?
      @thoughts = Thought.all
      @who_to_follow = User.all.first(5)
    else
      @thoughts = @current_user.followed_users_and_own_thoughts
      @who_to_follow = @current_user.not_followed
    end
  end

  def create
    @thought = @current_user.thoughts.build(thought_params)

    if @thought.save
      redirect_to thoughts_url, notice: 'Thought was successfully created.'
    else
      render :new
    end
  end

  private

  def set_thought
    @thought = Thought.find(params[:id])
  end

  def set_current_user
    if current_user.nil?
      session[:previous_url] = request.fullpath
      redirect_to sign_in_path
    else
      @current_user = current_user
    end
  end

  def thought_params
    params.require(:thought).permit(:text, :author_id)
  end
end
