require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  describe 'associations' do
    it { should have_many(:events) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
