class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, {only: [:edit, :update, :destroy]}

  def index
    # もしindexへのpath(microposts_path)にparams[:tag_name]があれば、
    if params[:tag_name]
    # params[:tag_name]に基づく投稿を取得・表示(タグ検索ページを表示)
      @microposts = Micropost.tagged_with(params[:tag_name].to_s).order(created_at: :desc).page(params[:page]).per(10)
    # よく使われるタグ10選も表示
      @tag_list = ActsAsTaggableOn::Tag.most_used(10)
    else
    # そうでなければ通常の投稿一覧ページを表示
    # ビューから送られてくる入力データを@qとし、
      @q = Micropost.ransack(params[:q])
    # @qに該当するインスタンスを1ページにつき10個表示する
      @microposts = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
    # もし@qに該当するインスタンスがなかったらflashを表示
      flash.now[:danger] = "該当する投稿が見つかりませんでした" if @microposts.empty?
    end
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
    @user = @micropost.user
    @comments = @micropost.comments.order(created_at: :desc)
    @comment = Comment.new # コメントフォームのインスタンスはmicropost/showで作成
    @latitude = @micropost.latitude
    @longitude = @micropost.longitude
    gon.lat = @latitude
    gon.lng = @longitude
  end

  def edit
    @micropost = Micropost.find_by(id: params[:id])
    @latitude = @micropost.latitude
    @longitude = @micropost.longitude
    gon.lat = @latitude
    gon.lng = @longitude
  end

  def update
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.update_attributes!(micropost_params)# 値を更新する
      flash[:success] = "投稿を更新しました"
      redirect_to @micropost
    else
      flash.now[:danger] = "入力に誤りがあります"
      render "microposts/edit"
    end
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
      params.require(:micropost).permit(:photo, :detail, :tag_list, :address, :latitude, :longitude).merge(user_id: current_user.id)
    end

    def correct_user
      @micropost = Micropost.find_by(id: params[:id])
      if current_user.id != @micropost.user.id
        flash[:danger] = "権限がありません"
        redirect_to microposts_path
      end
    end
end
