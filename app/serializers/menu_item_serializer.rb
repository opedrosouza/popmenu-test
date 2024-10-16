# == Schema Information
#
# Table name: menu_items
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string           not null
#  price       :decimal(, )      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  menu_id     :integer          not null
#
# Indexes
#
#  index_menu_items_on_menu_id  (menu_id)
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#
class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price

  belongs_to :menu, serializer: MenuSerializer

  def price
    object.price.to_f
  end
end
