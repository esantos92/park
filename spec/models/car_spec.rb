require 'rails_helper'

RSpec.describe Car, type: :model do
  it { is_expected.to validate_presence_of(:plate) }
  it { is_expected.to validate_presence_of(:status) }
end
