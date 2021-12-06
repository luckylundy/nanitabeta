class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_micropost
  before_action :comments_count_must_be_within_limit, {only: [:create]}

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

    def comments_count_must_be_within_limit
      @user = current_user
      @comment = Comment.new(comment_params)
      @micropost = Micropost.find_by(id: params[:micropost_id])
      @comments = @micropost.comments
      # コメントしようとしているユーザーが投稿者ではない && ユーザーの「特定の投稿」に対するコメントが3回以上であれば
      if @user != @micropost.user && @user.comments.where(micropost_id: @micropost.id).size >= 3
      # flashを出して元のページにレンダリング
        flash.now[:danger] = "特定の投稿に対するコメントは3回までです"
        render("microposts/show")
      end
    end
end
