class ShoppingCartsController < ApplicationController
  before_action :authenticate_user!, only:[:order]
  before_action :extract_shopping_cart
  before_action :get_item, only:[:add, :create, :remove]
  before_action :add_item, only:[:add, :create]

  def index
  end

  def add
  end

  def remove
    @shopping_cart.remove(@item, 1)
    redirect_to shopping_carts_path
  end

  def create
    redirect_to shopping_carts_path
  end

  def order
    @order = Order.new
    @delivery_info = current_user.delivery_info
  end

  def destroy
    @shopping_cart.clear
    redirect_to shopping_carts_path
  end

  private
  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end

  def get_item
    @item = Item.find(params[:item_id])
  end

  def add_item
    @shopping_cart.add(@item, @item.price)
  end
end
