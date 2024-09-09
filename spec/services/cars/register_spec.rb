require 'rails_helper'

RSpec.describe Cars::Register do
  subject { described_class.call(plate) }

  describe '#call' do
    context 'with a valid plate' do
      let(:plate) { 'ABC-1234' }

      it 'creates a Car register' do
        expect { subject }.to change(Car, :count).by(1)
        expect(Car.last.plate).to eq(Car.last.plate)
      end

      it 'creates a Payment register' do
        expect { subject }.to change(Payment, :count).by(1)
        expect(Payment.last.car_id).to eq(Car.last.id)
      end
    end

    context 'when plate is invalid' do
      let(:plate) { '1234-ABC' }

      it 'does not create a Car register' do
        expect { subject }.to not_change(Car, :count)
      end

      it 'does creates a Payment register' do
        expect { subject }.to not_change(Payment, :count)
      end
    end
  end
end
