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
class Menu < ApplicationRecord
  has_many :menu_items, dependent: :destroy, inverse_of: :menu

  validates :name, presence: true

  def slug
    name.parameterize
  end
end
