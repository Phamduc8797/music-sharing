class Singer < ApplicationRecord
  belongs_to :user
  has_one :image, as: :imageable, dependent: :destroy
  has_many :singer_songs
  has_many :songs, through: :singer_songs
  validates :name, presence: true, length: {
    maximum: Settings.validates.name.maximum}
  accepts_nested_attributes_for :image, reject_if: proc {|attributes|
    attributes['image_url'].blank?}
  scope :select_fields, ->{includes(:songs).select :id, :name, :info,
    :created_at}
  scope :by_lastest,->{order created_at: :desc}
end
