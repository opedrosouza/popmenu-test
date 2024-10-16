class AddRestaurantToMenu < ActiveRecord::Migration[7.2]
  def change
    # TODO: later on we need to make sure that the restaurant_id is not null
    add_reference :menus, :restaurant, null: true, foreign_key: true
  end
end
