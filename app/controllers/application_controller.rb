class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource) # ログイン後users/showページに遷移
    current_user
  end

  private
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end


  protected
    def configure_permitted_parameters
      # ユーザー登録時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :portrait])
      # ユーザー編集時にはnameとportrait、passwordのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :portrait, :remove_portrait, :password, :password_confirmation])
    end
end
