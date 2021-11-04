class RelationshipsController < ApplicationController
before_action :authenticate_user!

  def create
    @user = User.find_by(id: params[:id])
    current_user.follow(@user)
    redirect_to @user
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @relationship = current_user.relationships.find_by(followed_id: params[:id])
    current_user.unfollow(@relationship)
    redirect_to @user
  end
end
