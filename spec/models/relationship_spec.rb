require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:follow)).to be_valid
  end
end
