class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :microposts, dependent: :destroy # ユーザーは複数の投稿を所有する
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  validates :name, {presence: true, length: {maximum: 50}}
  validates :email, {presence: true}

  mount_uploader :portrait, PortraitUploader
                  # カラム名 # Uploader名
  
  def self.guest
    find_or_create_by!(email: "guest@gmail.com") do |user|
      user.name = "テストユーザー"
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end

  def follow(other_user)
    relationships.find_or_create_by!(followed_id: other_user.id)
    # 押すときは自分が主体なのでrelationshipsを使う
  end

  def unfollow(relationship)
    # relationships_controllerで定義した@relationshipを引数に取る
    relationships.find_by(followed_id: relationship.followed_id).destroy!
  end

  def following?(other_user)
    followings.include?(other_user)
  end

end
