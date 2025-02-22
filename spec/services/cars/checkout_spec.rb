require 'rails_helper'

RSpec.describe Cars::Checkout do
  subject { described_class.call(car) }

  describe '#call' do
    context 'with a valid car' do
      let(:car) { create(:car) }
      let!(:payment) { create(:payment, :paid, car: car)}

      it 'register car exit' do
        expect(subject).to be_truthy
        expect(car.checkouted?).to be_truthy
      end
    end
  end
end
