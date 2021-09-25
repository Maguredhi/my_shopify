class CartsController < ApplicationController
  # 有登入才可以進來這 controller
  before_action :authenticate_user!

  def show
  end

  def destroy
    session[:cart_session] = nil
    redirect_to root_path, notice: '購物車已清空'
  end

  def checkout
    @order = current_user.orders.build
  end
end
