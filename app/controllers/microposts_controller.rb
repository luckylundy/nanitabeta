class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, {only: [:edit, :update, :destroy]}

  def index
    @microposts = Micropost.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.new(micropost_params)
    if @micropost.save
      flash[:primary] = "投稿が保存されました"
      redirect_to microposts_path
    else
      flash.now[:danger] = "投稿に失敗しました"
      render("microposts/new")
    end
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
    @comments = @micropost.comments
    @comment = Comment.new # コメントフォームのインスタンスはmicropost/showで作成
  end

  def edit
    @micropost = Micropost.find_by(id: params[:id])
  end

  def update

  end

  def destroy
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.destroy
      flash[:danger] = "投稿を削除しました"
      redirect_to microposts_path
    end
  end

  
  private

    def micropost_params
      params.require(:micropost).permit(:photo, :detail, :tag_list).merge(user_id: current_user.id)
    end

    def correct_user
      @micropost = Micropost.find_by(id: params[:id])
      if current_user.id != @micropost.user.id
        flash[:danger] = "権限がありません"
        redirect_to microposts_path
      end
    end
end
