require 'rails_helper'

RSpec.describe Protocol, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:proto)).to be_valid
  end
end
