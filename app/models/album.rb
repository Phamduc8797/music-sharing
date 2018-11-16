class Album < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable
  has_many :album_songs
  has_many :songs, through: :album_songs
  scope :oder_name, -> {order name: :desc}
  validates :name, presence: true, length: {maximum: Settings.validates.name.maximum}
end
