require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'username' do
      it 'validates format' do
        invalid = FactoryBot.build(:user, username: "-1$Invalid")
        valid = FactoryBot.build(:user, username: "valid_user_1")

        expect(invalid).not_to be_valid
        expect(valid).to be_valid
      end
    end
  end
end
