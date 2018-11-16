class Lyric < ApplicationRecord
  belongs_to :user
  belongs_to :song
  scope :accepted, -> {
    where(accepted: true)
  }
  validates :content, presence: true
end
