require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  before { create_list(:restaurant, 3) }

  describe "GET /restaurants" do
    before { get restaurants_path }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of restaurants" do
      expect(json_body.count).to eq(3)
    end

    it "returns the correct data" do
      serialized_restaurants = Restaurant.all.map { |restaurant| RestaurantSerializer.new(restaurant).as_json }

      expect(json_body).to match_array(serialized_restaurants)
    end
  end

  describe "GET /restaurants/:id" do
    let(:restaurant) { Restaurant.first }

    before { get restaurant_path(restaurant) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the correct data" do
      expect(json_body).to eq(RestaurantSerializer.new(restaurant).as_json)
    end

    context "when the restaurant does not exist" do
      before { get restaurant_path(999) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
