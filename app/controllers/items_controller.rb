class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :add]

  def index
    @items = Item.where(disable_flg: 0).order(:sort_order)
  end

  def show
  end

  def add
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :image, :price, :description, :disable_flg, :sort_order)
    end
end
