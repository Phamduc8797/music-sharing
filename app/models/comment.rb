class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :song
  scope :order_time, -> {order created_at: :desc}
end
