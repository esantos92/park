module Cars
  class Register
    def self.call(plate)
      new(plate).call
    end

    def initialize(plate)
      @plate = plate
    end

    attr_reader :car, :plate

    def call
      validate!

      ApplicationRecord.transaction do
        register_car!
        create_payment!
      end
    end

    private

    def validate!
      
      # binding.pry
      
      raise ArgumentError, 'This car has some enter opened registered' if car_has_opened_enter?
    end

    def car_has_opened_enter?
      Car.where(plate: plate).entered.present?
    end

    def register_car!
      @car = Car.create!(plate: plate)
    end

    def create_payment!
      Payment.create!(car: car)
    end
  end
end
