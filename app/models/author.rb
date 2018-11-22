class Author < ApplicationRecord
  has_one :image, as: :imageable, dependent: :destroy
  belongs_to :user
  has_many :author_songs
  has_many :songs, through: :author_songs
  validates :name, presence: true, length: {
    maximum: Settings.validates.name.maximum}
  accepts_nested_attributes_for :image, reject_if: proc {|attributes|
    attributes['image_url'].blank?}
  scope :select_fields, ->{includes(:songs).select :id, :name, :info,
    :created_at}
  scope :by_lastest,->{order created_at: :desc}
end
