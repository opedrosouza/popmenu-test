class MenusController < ApplicationController
  def index
    @menus = Menu.all.includes(:menu_items).order(:name)
    render json: @menus
  end

  def show
    render json: menu
  end

  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      render json: @menu, status: :created
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  def update
    if menu.update(menu_params)
      render json: menu
    else
      render json: menu.errors, status: :unprocessable_entity
    end
  end

  def destroy
    menu.destroy
  end

  private

  def menu
    @menu ||= Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :description)
  end
end
