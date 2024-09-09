require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:car) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:car_id) }
  end

  describe 'state machine' do
    context 'when pending' do
      subject { build(:payment) }

      it { is_expected.to allow_transition_to(:paid) }
    end

    context 'when paid' do
      subject { build(:payment, :paid) }

      it { is_expected.not_to allow_transition_to(:pending) }
    end
  end
end
