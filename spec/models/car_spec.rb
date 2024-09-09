require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:payments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:plate) }
    it { is_expected.to validate_presence_of(:status) }

    context 'an invalid plate' do
      let(:car) { build(:car, plate: 'aaaaaa') }

      it do
        expect { car.save! }
          .to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Plate format must be AAA-1234')
      end
    end
  end

  describe 'state machine' do
    context 'when entered' do
      subject { build(:car) }

      it { is_expected.to allow_transition_to(:checkouted) }
    end

    context 'when checkouted' do
      subject { build(:car, :checkouted) }

      it { is_expected.not_to allow_transition_to(:entered) }
    end
  end
end
