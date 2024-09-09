require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:payments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:plate) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
