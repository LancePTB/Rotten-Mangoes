class Admin::UsersController < ApplicationController
  def index
    @users = User.order("id").page(params[:user]) #.per(5)
  end
end