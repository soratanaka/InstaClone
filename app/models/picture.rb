class Picture < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  validates :user_id, {presence: true}
  validates :content, {presence: true, length: {maximum: 140}}
  validates :image, {presence: true}
  mount_uploader :image, ImageUploader
end
