class Users::GuestSessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    # sign_inはdeviseのログインメソッド
    sign_in user
    # pages#indexに飛ぶ
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
