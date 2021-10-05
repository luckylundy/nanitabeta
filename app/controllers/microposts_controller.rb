class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new(micropost_params)
    if @micropost.photo
      @micropost.save
      redirect_to microposts_path
      flash[:notice] = "投稿が保存されました"
    else
      render("micropost/new")
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
  end

  def edit
  end

  def update

  end

  def destroy

  end

  
  private

    def micropost_params
      params.require(:micropost).permit(:photo, :detail, :tag_list)
    end
end
