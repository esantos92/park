module Cars
  class Checkout
    def self.call(car)
      new(car).call
    end

    def initialize(car)
      @car = car
    end

    attr_reader :car

    def call
      validate!
      checkout_car
    end

    private

    def validate!
      raise ArgumentError, 'Car does not have a paid payment' unless car_has_a_paid_payment?
    end

    def car_has_a_paid_payment?
      car.payments.paid.present?
    end

    def checkout_car
      car.checkout! if car.may_checkout?
    end
  end
end
