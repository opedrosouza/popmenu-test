class RestaurantsController < ApplicationController
  before_action :restaurant, only: :show

  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def show
    render json: restaurant
  end

  private

  def restaurant
    @restaurant ||= Restaurant.find(params[:id])
  end
end
