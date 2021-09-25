class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.all
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
  end

  def edit
  end

  
  private

    def micropost_params
      params.require(:micropost).permit(:photo, :detail)
    end
end
