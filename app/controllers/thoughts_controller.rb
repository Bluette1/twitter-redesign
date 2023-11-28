class ThoughtsController < ApplicationController
  include TrendsHelper

  before_action :set_current_user, only: %i[create]
  def index
    @trends = trends

    @thought = Thought.new
    @all_thoughts = Thought.all
    if current_user.nil?
      @thoughts = @all_thoughts
      @who_to_follow = User.all.first(5)
      who_to_follow_detail_not_loggedin
    else
      @thoughts = @current_user.followed_users_and_own_thoughts
      @who_to_follow = @current_user.not_followed
      who_to_follow_detail_loggedin
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

  def who_to_follow_detail_not_loggedin
    @who_to_follow_detail = []
    authors = []
    @thoughts.each do |thought|
      @who_to_follow_detail << thought unless authors.include?(thought.author)
      authors << thought.author unless authors.include?(thought.author)
    end
  end

  def who_to_follow_detail_loggedin
    @who_to_follow_detail = []
    authors = []
    @all_thoughts.each do |thought|
      @who_to_follow_detail << thought if @who_to_follow.include?(thought.author) && !authors.include?(thought.author)
      authors << thought.author unless authors.include?(thought.author)
    end
  end
end
