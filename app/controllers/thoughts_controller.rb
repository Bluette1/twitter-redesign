class ThoughtsController < ApplicationController
  before_action :set_thought, only: %i[show edit update destroy]
  before_action :set_current_user, only: %i[show index new create]

  # GET /thoughts
  # GET /thoughts.json
  def index
    @thought = Thought.new
    @thoughts = @current_user.followed_users_and_own_thoughts
    @who_to_follow = @current_user.not_followed
  end

  # GET /thoughts/1
  # GET /thoughts/1.json
  def show; end

  # GET /thoughts/1/edit
  def edit; end

  # POST /thoughts
  # POST /thoughts.json
  def create
    @thought = @current_user.thoughts.build(thought_params)

    respond_to do |format|
      if @thought.save
        format.html { redirect_to thoughts_url, notice: 'Thought was successfully created.' }
        format.json { render :show, status: :created, location: @thought }
      else
        format.html { render :new }
        format.json { render json: @thought.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /thoughts/1
  # PATCH/PUT /thoughts/1.json
  def update
    respond_to do |format|
      if @thought.update(thought_params)
        format.html { redirect_to @thought, notice: 'Thought was successfully updated.' }
        format.json { render :show, status: :ok, location: @thought }
      else
        format.html { render :edit }
        format.json { render json: @thought.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thoughts/1
  # DELETE /thoughts/1.json
  def destroy
    @thought.destroy
    respond_to do |format|
      format.html { redirect_to thoughts_url, notice: 'Thought was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_thought
    @thought = Thought.find(params[:id])
  end

  def set_current_user
    if current_user.nil?
      session[:previous_url] = request.fullpath unless request.fullpath =~ Regexp.new('/user/')
      redirect_to sign_in_path
    end
    @current_user = current_user
  end

  # Only allow a list of trusted parameters through.
  def thought_params
    params.require(:thought).permit(:text, :author_id)
  end
end
