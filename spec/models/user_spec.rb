require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(username: 'some_name', full_name: 'good name')
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { should validate_uniqueness_of(:username) }

    it { should validate_presence_of(:full_name) }

    it 'is not valid without a username' do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it { should validate_presence_of(:username) }

    it 'is not valid without the minimum length of username' do
      subject.username = 'd'

      expect(subject).to_not be_valid
    end

    it 'is not valid without the minimum length of fullname' do
      subject.full_name = 'd'

      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:followings_as_follower) }
    it { should have_many(:followings) }
    it { should have_many(:followed_users).through(:followings_as_follower) }
    it { should have_many(:thoughts) }
    it { should have_many(:followers).through(:followings) }
    it { should have_many(:bookmarks) }
  end
end
