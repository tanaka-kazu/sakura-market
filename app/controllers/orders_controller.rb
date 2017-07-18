class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.order.all
  end

  def show
    @order_items = OrderItem.where(order_id: params[:id])
  end

  def create
    @order = Order.new(order_params.merge(order_date: Time.current))
    order_items.each do |order_item|
        @order.order_items.new(item_id: order_item.item.id, quantity: order_item.quantity)
    end
    respond_to do |format|
      if @order.save
        ShoppingCart.find(cart_id).clear
        format.html { render :complete, notice: '商品注文が確定しました.' }
      else
        format.html { redirect_to shopping_carts_path, notice: '商品注文に失敗しました.' }
       end
    end
  end

  private
    def order_params
      params.require(:order).permit(:user_id, :order_date, :delivery_info_id, :delivery_date, :time_range_id, :settlement_charge, :delivery_charge).merge(user_id: current_user.id)
    end

    def cart_id
      session[:shopping_cart_id]
    end

    def order_items
      ShoppingCart.find(cart_id).shopping_cart_items
    end
end

