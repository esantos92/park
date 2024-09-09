require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:car) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:car_id) }
  end
end
