class UsersController < ApplicationController
  before_action :sign_in_required

  def index
    @q = User.ransack(params[:q])
    if params[:all_users]
      @users = User.order(created_at: :desc).page(params[:page]).per(6)
    else
      @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(6)
      flash.now[:danger] = "該当するユーザーが見つかりませんでした" if @users.empty?
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def likes # ユーザーがお気に入り登録した投稿一覧を表示する
    @user = User.find_by(id: params[:id])
    liked = Like.where(user_id: @user.id).pluck(:micropost_id) # user_idが@user.idのlikeを集め、それらのmicropost_idを取得する
    @likes = Micropost.find(liked)
    @likes = Kaminari.paginate_array(@likes).page(params[:page]).per(10) # @userがお気に入り登録したmicropost_idを持つ全ての投稿を返す
  end

  def followings
    @user = User.find_by(id: params[:id])
    @users = @user.followings.order(created_at: :desc).page(params[:page]).per(6)
  end

  def followers
    @user = User.find_by(id: params[:id])
    @users = @user.followers.order(created_at: :desc).page(params[:page]).per(6)
  end
end
