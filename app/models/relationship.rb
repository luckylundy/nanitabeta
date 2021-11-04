class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" 
  belongs_to :followed, class_name: "User"
  # class_name: "User"を定義することでusersテーブルを参照するよう指示

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
