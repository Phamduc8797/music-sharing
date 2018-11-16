class Lyric < ApplicationRecord
  belongs_to :user
  belongs_to :song
  scope :accepted, -> {
    where(accepted: true)
  }
  validates :content, presence: true

  def accept_lyric!
    update_attribute :accepted, true
  end

  def unaccept_lyric!
    update_attribute :accepted, false
  end
end
