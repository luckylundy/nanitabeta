class Users::GuestSessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    # sign_inはdeviseのログインメソッド
    sign_in user
    # microposts#indexに遷移
    redirect_to microposts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
