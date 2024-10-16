if Rails.env.local?
  restaurants = FactoryBot.create_list(:restaurant, 3)
  restaurants.each do |restaurant|
    FactoryBot.create_list(:menu, 3, :with_menu_items, restaurant: restaurant)
  end
end
