class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :slug

  has_many :menu_items, serializer: MenuItemSerializer
end
