class Album < ApplicationRecord
  belongs_to :user
  has_one :image, as: :imageable, dependent: :destroy
  has_many :album_songs, dependent: :destroy
  has_many :songs, through: :album_songs
  scope :order_name, -> {order name: :desc}
  validates :name, presence: true, length: {maximum: Settings.validates.name.maximum}
  accepts_nested_attributes_for :image,
    reject_if: proc {|attributes| attributes["image_url"].blank?}
end
