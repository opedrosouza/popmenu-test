# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'associations' do
    it { should have_many(:menus).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#slug' do
    it 'returns a parameterized version of the name' do
      restaurant = create(:restaurant, name: 'Tasty Treats')

      expect(restaurant.slug).to eq('tasty-treats')
    end
  end
end
