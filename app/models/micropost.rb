class Micropost < ApplicationRecord
  belongs_to :user # 投稿は一人のユーザーに所有されている
  has_many :comments, dependent: :destroy

  validates :user_id, {presence: true}
  validates :photo, {presence: true}



  acts_as_taggable_on :tags # Micropostモデルとtag_listを関連付け
  mount_uploader :photo, PhotoUploader

  
end
