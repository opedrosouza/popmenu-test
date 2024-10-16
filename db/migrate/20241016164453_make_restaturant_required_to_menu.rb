# TODO: Be sure to run the command `rails migrate_menus_without_restaurant` before this migration
class MakeRestaturantRequiredToMenu < ActiveRecord::Migration[7.2]
  def change
    change_column_null :menus, :restaurant_id, false
  end
end
