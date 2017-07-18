class DeliveryInfosController < ApplicationController
  layout 'application'
  before_action :set_delivery_info, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :edit]

  def new
    @delivery_info = DeliveryInfo.new
  end

  def edit
  end

  def create
    @delivery_info = DeliveryInfo.new(delivery_info_params)

    respond_to do |format|
      if @delivery_info.save
        format.html { redirect_to current_user, notice: '配送先情報を登録しました.' }
      else
        format.html { redirect_to current_user, notice: '配送先情報の登録に失敗しました.' }
       end
    end
  end

  def update
    respond_to do |format|
      if @delivery_info.update(delivery_info_params)
        format.html { redirect_to current_user, notice: '配送先情報を更新しました.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @delivery_info.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: '配送先情報を削除しました.' }
    end
  end

  private
    def set_user
      @user = current_user
    end

    def set_delivery_info
      @delivery_info = current_user.delivery_info
    end

    def delivery_info_params
      params.require(:delivery_info).permit(:name, :address).merge(user_id: current_user.id)
    end
end
