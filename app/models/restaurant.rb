# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Restaurant < ApplicationRecord
  has_many :menus, dependent: :destroy, inverse_of: :restaurant

  validates :name, presence: true

  def slug
    name.parameterize
  end
end
