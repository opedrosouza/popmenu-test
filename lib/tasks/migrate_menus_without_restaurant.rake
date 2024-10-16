desc "Migrate all menus without a restaurant to the first restaurant"
task migrate_menus_without_restaurant: :environment do
  ActiveRecord::Base.transaction do
    first_restaurant = Restaurant.first
    Menu.where(restaurant_id: nil).update_all(restaurant_id: first_restaurant.id)
  end
end
