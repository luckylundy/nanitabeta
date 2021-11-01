class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_micropost

  def create
    if current_user.id != @micropost.user.id
      @like = Like.new(user_id: current_user.id, micropost_id: @micropost.id)
      @like.save
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, micropost_id: @micropost.id)
    @like.destroy
  end


  private
    def set_micropost
      @micropost = Micropost.find_by(id: params[:micropost_id])
    end
end
