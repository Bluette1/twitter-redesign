class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    session[:current_user_id] = @user.id if @user

    if @user

      path_url = session[:previous_url] || user_path(@user)

      redirect_to path_url, notice: 'You have successfully logged in'

    else
      flash[:notice] = 'Wrong name. Sign up or enter the correct name'
      render :new
    end
  end

  # DELETE /sessions/1
  def destroy
    session[:current_user_id] = nil
    redirect_to sign_in_url, notice: 'You have successfully logged out.'
  end

  private

  # Only allow a list of trusted parameters through.
  def session_params
    params.fetch(:session, {})
  end
end
