class Car < ApplicationRecord
  include AASM

  has_many :payments

  validates :plate, :status, presence: true
  validates :plate, format: { with: /\A[A-Z]{3}-\d{4}\z/, message: 'format must be AAA-1234' }

  aasm column: :status do
    state :entered, initial: true
    state :checkouted, before_enter: :assign_check_out

    event :checkout do
      transitions from: :entered, to: :checkouted
    end
  end

  def assign_check_out
    self.check_out ||= Time.zone.now
  end
end
