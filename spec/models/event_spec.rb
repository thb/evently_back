require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'has a valid factory' do
    expect(build(:event)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:place).required }
    it { should belong_to(:category).required }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
