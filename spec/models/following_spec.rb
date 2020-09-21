require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'Validations' do
    let(:follower) do
      User.create(username: 'follower', full_name: 'Good Follower')
    end

    let(:followed) do
      User.create(username: 'follower', full_name: 'Good Followed')
    end

    let(:subject) do
      described_class.new(follower_id: follower.id, followed: followed.id)
    end

    it 'is not valid without a follower' do
      subject.follower = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a followed user' do
      subject.followed = nil
      expect(subject).to_not be_valid
    end
  end
  describe 'Associations' do
    it { should belong_to(:follower) }
    it { should belong_to(:followed) }
  end
end
