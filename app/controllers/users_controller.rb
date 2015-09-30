class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.notify_email(@user)
    redirect_to("/admin/users", notice: 'User was successfully deleted.')
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end
