# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe 'follow behaviour' do
    let(:user) { FactoryBot.create(:user) }
    let(:another_user) { FactoryBot.create(:user) }

    context 'when following another user' do
      before do
        FactoryBot.create(:relationship, follower: user, followed: another_user)
      end

      it 'has followed' do
        expect(user.following.count).to eq(1)
      end
    end

    context 'when followed' do
      before do
        FactoryBot.create(:relationship, follower: another_user, followed: user)
      end

      it 'has followers' do
        expect(user.followers.count).to eq(1)
      end
    end
  end

  describe 'validations' do
    describe 'username' do
      it 'validates format' do
        invalid = FactoryBot.build(:user, username: '-1$Invalid')
        valid = FactoryBot.build(:user, username: 'valid_user_1')

        expect(invalid).not_to be_valid
        expect(valid).to be_valid
      end
    end
  end
end
