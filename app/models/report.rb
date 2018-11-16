class Report < ApplicationRecord
  belongs_to :user
  belongs_to :song
end
