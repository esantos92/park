class Car < ApplicationRecord
  has_many :payments

  validates :plate, :status, presence: true
  validates :plate, format: { with: /\A[A-Z]{3}-\d{4}\z/, message: 'format must be AAA-1234' }
end
