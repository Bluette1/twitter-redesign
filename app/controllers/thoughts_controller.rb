class ThoughtsController < ApplicationController
  before_action :set_current_user, only: %i[index create]

  # GET /thoughts
  # GET /thoughts.json
  def index
    @thought = Thought.new
    @thoughts = @current_user.followed_users_and_own_thoughts
    @who_to_follow = @current_user.not_followed
  end

  # POST /thoughts
  # POST /thoughts.json
  def create
    @thought = @current_user.thoughts.build(thought_params)

    if @thought.save
      redirect_to thoughts_url, notice: 'Thought was successfully created.'
    else
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_thought
    @thought = Thought.find(params[:id])
  end

  def set_current_user
    if current_user.nil?
      session[:previous_url] = request.fullpath 
      # unless request.fullpath =~ Regexp.new('/user/')
      redirect_to sign_in_path
    end
    @current_user = current_user
  end

  # Only allow a list of trusted parameters through.
  def thought_params
    params.require(:thought).permit(:text, :author_id)
  end
end
