require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe '.after_create => initialize_repository' do
    context 'for a protocol resource'  do
      let(:repo) { FactoryBot.build(:repo) }

      it 'initializes a git repo' do
        expect { 
          repo.save!
        }.to change {
          File.exist?(Rails.root.join("tmp/git/#{repo.user}/#{repo.name}.git"))
        }.from(false).to(true)
      end
    end
  end
end
