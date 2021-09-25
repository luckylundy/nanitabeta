class UsersController < ApplicationController
  before_action :sign_in_required

  def index
    @users = User.page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
  end
end
