class Payment < ApplicationRecord
  include AASM

  belongs_to :car

  aasm column: :status do
    state :pending, initial: true
    state :paid

    event :pay do
      transitions from: :pending, to: :paid
    end
  end
end
