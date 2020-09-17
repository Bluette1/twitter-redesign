require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'Validations' do
    let(:bookmarker) do
      User.create(username: 'bookmarker', full_name: 'Good Name')
    end
    let(:author) do
      User.create(username: 'author', full_name: 'Good Author')
    end
    let(:thought) do
      Thought.create(text: 'some text', author: author)
    end

    subject do
      described_class.new(user_id: bookmarker.id, thought_id: thought.id)
    end

    it 'should validate uniqueness of user -> scope thought' do
      described_class.create(user_id: bookmarker.id, thought_id: thought.id)
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to eq ['User has already been taken']
    end
  end
  
  describe 'Associations' do
    it { should belong_to(:thought) }
    it { should belong_to(:user) }
  end
end
