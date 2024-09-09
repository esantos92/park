class Car < ApplicationRecord
  has_many :payments

  validates :plate, :status, presence: true
end
