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
      ApplicationRecord.transaction do
        register_car!
        create_payment!
      end
    rescue StandardError => e
      e.message
    end

    private

    def register_car!
      @car = Car.create!(plate: plate)
    end

    def create_payment!
      Payment.create!(car: car)
    end
  end
end
