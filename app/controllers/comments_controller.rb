class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_micropost

  def create
    @comments = @micropost.comments
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:primary] = "コメントしました"
      redirect_to @micropost
    else
      flash.now[:danger] = "コメントを入力してください"
      render("microposts/show")
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment.destroy
      flash[:danger] = "コメントを削除しました"
      redirect_to micropost_path(@micropost)
    end
  end


  private
    def set_micropost
      @micropost = Micropost.find_by(id: params[:micropost_id])
    end

    def comment_params
      params.required(:comment).permit(:content).merge(user_id: current_user.id, micropost_id: params[:micropost_id])
    end
end
