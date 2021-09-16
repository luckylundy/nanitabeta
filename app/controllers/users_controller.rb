class UsersController < ApplicationController
  before_action :sign_in_required

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
