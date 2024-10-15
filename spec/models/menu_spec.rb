# == Schema Information
#
# Table name: menus
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'associations' do
    it { should have_many(:menu_items).dependent(:destroy).inverse_of(:menu) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#slug' do
    it 'returns a parameterized version of the name' do
      menu = create(:menu, name: 'Tasty Treats')

      expect(menu.slug).to eq('tasty-treats')
    end
  end
end
