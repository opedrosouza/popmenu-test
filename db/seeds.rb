if Rails.env.local?
  FactoryBot.create_list(:menu, 3, :with_menu_items)
end
