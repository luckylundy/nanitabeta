class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  mount_uploader :portrait, PortraitUploader
                  # カラム名 # Uploader名
  
  def self.guest
    find_or_create_by!(email: "guest@gmail.com") do |user|
      user.name = "テストユーザー"
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end
end
