require 'rails_helper'

RSpec.describe "MenusController", type: :request do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu, restaurant: restaurant) }

  describe "GET /restaurant/:restaurant_id/menus" do
    before { get restaurant_menus_path(restaurant) }
    let(:serialized_menus) { restaurant.menus.map { |menu| MenuSerializer.new(menu).as_json } }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of menus" do
      expect(json_body.count).to eq(1)
    end

    it "returns the correct data" do
      expect(json_body).to match_array(serialized_menus)
    end
  end

  describe "GET /restaurant/:restaurant_id/menus/:id" do
    context "when the menu exists" do
      before { get restaurant_menu_path(restaurant, id: menu.id) }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns the correct data" do
        expect(json_body).to eq(MenuSerializer.new(menu).as_json)
      end
    end

    context "when the menu does not exist" do
      before { get restaurant_menu_path(restaurant, id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /restaurant/:restaurant_id/menus" do
    context "with invalid parameters" do
      let(:menu_params) { { name: "" } }

      before { post restaurant_menus_path(restaurant), params: { menu: menu_params } }

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct data" do
        expect(json_body).to eq({ name: [ "can't be blank" ] })
      end
    end

    context "with valid parameters" do
      let(:menu_params) { attributes_for(:menu) }

      before { post restaurant_menus_path(restaurant), params: { menu: menu_params } }

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it "returns the correct data" do
        expect(json_body).to eq(MenuSerializer.new(Menu.last).as_json)
      end
    end
  end

  describe "PUT /restaurant/:restaurant_id/menus/:id" do
    context "with invalid parameters" do
      let(:menu_params) { { name: "" } }

      before { put restaurant_menu_path(restaurant, id: menu.id), params: { menu: menu_params } }

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct data" do
        expect(json_body).to eq({ name: [ "can't be blank" ] })
      end
    end

    context "with valid parameters" do
      let(:menu_params) { { name: "New Name" } }

      before { put restaurant_menu_path(restaurant, id: menu.id), params: { menu: menu_params } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns the correct data" do
        expect(json_body).to eq(MenuSerializer.new(menu.reload).as_json)
      end
    end

    context "when the menu does not exist" do
      before { put restaurant_menu_path(restaurant, id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE restaurants/:restaurant_id/menus/:id" do
    before { delete restaurant_menu_path(restaurant, id: menu.id) }

    it "returns http no content" do
      expect(response).to have_http_status(:no_content)
    end

    it "deletes the menu" do
      expect(restaurant.reload.menus.count).to eq(0)
    end

    context "when the menu does not exist" do
      before { delete restaurant_menu_path(restaurant, id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
