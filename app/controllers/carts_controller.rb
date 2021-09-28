class CartsController < ApplicationController
  # 有登入才可以進來這 controller
  before_action :authenticate_user!
  helper_method :find_sku

  def show
  end

  def destroy
    session[:cart_session] = nil
    redirect_to root_path, notice: t('notice.clear_cart_message')
  end

  def checkout
    @order = current_user.orders.build
  end

  def find_sku(sku_id)
    Sku.find(sku_id)
  end
end
