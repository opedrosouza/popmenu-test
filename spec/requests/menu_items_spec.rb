require 'rails_helper'

RSpec.describe "MenuItemsController", type: :request do
  let!(:menu) { create(:menu, :with_menu_items) }
  let!(:other_menu) { create(:menu, :with_menu_items) }

  describe "GET /menus/:menu_id/menu_items" do
    before { get menu_menu_items_path(menu) }
    let(:serialized_menu_items) { menu.menu_items.map { |menu_item| MenuItemSerializer.new(menu_item).as_json } }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of menu items" do
      expect(json_body.count).to eq(3)
    end

    it "returns the correct data" do
      expect(json_body).to match_array(serialized_menu_items)
    end

    it "does not return menu items from other menus" do
      other_menu.menu_items.each do |menu_item|
        expect(json_body).not_to include(MenuItemSerializer.new(menu_item).as_json)
      end
    end

    context "when the menu does not exist" do
      before { get menu_menu_items_path(menu_id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /menus/:menu_id/menu_items/:id" do
    context "when the menu item exists" do
      let(:menu_item) { menu.menu_items.first }
      before { get menu_menu_item_path(menu, menu_item) }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns the correct data" do
        expect(json_body).to eq(MenuItemSerializer.new(menu_item).as_json)
      end
    end

    context "when the menu item does not exist" do
      before { get menu_menu_item_path(menu, id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
