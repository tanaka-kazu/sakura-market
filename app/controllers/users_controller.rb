class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]

  def show
    @delivery_info = current_user.delivery_info
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'ユーザー情報を更新しました.' }
      else
        @delivery_info = current_user.delivery_info
        format.html { render :show, notice: 'ユーザー情報の更新に失敗しました' }
      end
    end
  end

private
    def set_user
      @user = User.find_or_create_by(id: current_user.id)
    end

    def user_params
      params.require(:user).permit(:nickname)
    end
end
