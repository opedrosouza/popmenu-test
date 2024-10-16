class MenuItemsController < ApplicationController
  def index
    render json: menu.menu_items
  end

  def show
    render json: menu_item
  end

  private

  def menu
    @menu ||= Menu.find(params[:menu_id])
  end

  def menu_item
    @menu_item ||= menu.menu_items.find(params[:id])
  end
end
