require 'rails_helper'

RSpec.describe "MenusController", type: :request do
  before do
    create_list(:menu, 3)
  end

  describe "GET /menus" do
    before { get menus_path }
    let(:serialized_menus) { Menu.all.map { |menu| MenuSerializer.new(menu).as_json } }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of menus" do
      expect(json_body.count).to eq(3)
    end

    it "returns the correct data" do
      expect(json_body).to match_array(serialized_menus)
    end
  end

  describe "GET /menus/:id" do
    context "when the menu exists" do
      let(:menu) { Menu.first }
      before { get menu_path(menu) }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns the correct data" do
        expect(json_body).to eq(MenuSerializer.new(menu).as_json)
      end
    end

    context "when the menu does not exist" do
      before { get menu_path(id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /menus" do
    context "with invalid parameters" do
      let(:menu_params) { { name: "" } }

      before { post menus_path, params: { menu: menu_params } }

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct data" do
        expect(json_body).to eq({ name: [ "can't be blank" ] })
      end
    end

    context "with valid parameters" do
      let(:menu_params) { attributes_for(:menu) }

      before { post menus_path, params: { menu: menu_params } }

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it "returns the correct data" do
        expect(json_body).to eq(MenuSerializer.new(Menu.last).as_json)
      end
    end
  end

  describe "PUT /menus/:id" do
    let(:menu) { Menu.first }

    context "with invalid parameters" do
      let(:menu_params) { { name: "" } }

      before { put menu_path(menu), params: { menu: menu_params } }

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct data" do
        expect(json_body).to eq({ name: [ "can't be blank" ] })
      end
    end

    context "with valid parameters" do
      let(:menu_params) { { name: "New Name" } }

      before { put menu_path(menu), params: { menu: menu_params } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns the correct data" do
        expect(json_body).to eq(MenuSerializer.new(menu.reload).as_json)
      end
    end

    context "when the menu does not exist" do
      before { put menu_path(id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /menus/:id" do
    let(:menu) { Menu.first }

    before { delete menu_path(menu) }

    it "returns http no content" do
      expect(response).to have_http_status(:no_content)
    end

    it "deletes the menu" do
      expect(Menu.count).to eq(2)
    end

    context "when the menu does not exist" do
      before { delete menu_path(id: 999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
