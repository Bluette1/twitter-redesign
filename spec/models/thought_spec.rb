require 'rails_helper'

RSpec.describe Thought, type: :model do
  describe 'Validations' do
    let(:author) do
        User.create(username: 'author', full_name: 'Good Author')
      end
    let(:subject) do
      described_class.new(text: 'some text', author: author)
    end
    it 'is not valid without a user' do
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it { should validate_presence_of(:text) }
  end

  describe 'Associations' do
    it { should belong_to(:author) }
    it { should have_many(:bookmarks) }
  end
end
