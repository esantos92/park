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
end
