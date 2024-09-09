class Payment < ApplicationRecord
  belongs_to :car

  validates :car_id, presence: true
end
