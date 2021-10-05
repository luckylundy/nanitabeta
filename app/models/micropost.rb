class Micropost < ApplicationRecord
  validates :photo, {presence: true}

  acts_as_taggable
  mount_uploader :photo, PhotoUploader

end
