require 'rails_helper'

RSpec.describe FavoriteProtocol, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:favorite_protocol)).to be_valid
  end
end
