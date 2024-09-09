class Car < ApplicationRecord
  validates :plate, :status, presence: true
end
