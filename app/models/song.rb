class Song < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one :image, as: :imageable, dependent: :destroy
  has_many :lyrics, dependent: :destroy
  has_many :album_songs
  has_many :albums, through: :album_songs, dependent: :destroy
  has_many :author_songs
  has_many :authors, through: :author_songs, dependent: :destroy
  has_many :singer_songs
  has_many :singers, through: :singer_songs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :reports, dependent: :destroy
  mount_uploader :song_url, AudioUploader
  validates :name, presence: true, length:
    {maximum: Settings.validates.name.maximum}
  validates :song_url, presence: true
  accepts_nested_attributes_for :authors, :singers,
    reject_if: proc {|attributes| attributes["name"].blank?}
  accepts_nested_attributes_for :image,
    reject_if: proc {|attributes| attributes["image_url"].blank?}
  scope :order_at, -> {order created_at: :desc}
  scope :get_song, (lambda do
    all.order("created_at asc").limit(Settings.get_song.limit)
  end)

  def increase_view
    self.view += 1
    self.save!
  end
end
