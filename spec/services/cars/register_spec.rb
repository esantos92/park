require 'rails_helper'

RSpec.describe Cars::Register do
  subject { described_class.call(plate) }

  describe '#call' do
    context 'with a valid plate' do
      let(:plate) { 'CBA-1234' }

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
        expect { subject }.to raise_error(StandardError)
        expect(Car.count).to eq(0)
      end

      it 'does creates a Payment register' do
        expect { subject }.to raise_error(StandardError)
        expect(Payment.count).to eq(0)
      end
    end

    context 'when occurs some error with payment creation' do
      before { allow(Payment).to receive(:create!).and_return(StandardError) }

      it 'does not create a Car register' do
        expect { subject }.to raise_error(StandardError)
        expect(Car.count).to eq(0)
      end

      it 'does not create a Payment register' do
        expect { subject }.to raise_error(StandardError)
        expect(Payment.count).to eq(0)
      end
    end

    context 'when car has some opened enter registered' do
      let(:car) { create(:car) }

      subject { described_class.call(car.plate) }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
