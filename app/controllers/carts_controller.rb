class CartsController < ApplicationController
  # 有登入才可以進來這 controller
  before_action :authenticate_user!

  def payment
  end

  def show
  end

  def destroy
    session[:cart_session] = nil
    redirect_to root_path, notice: t('notice.clear_cart_message')
  end

  def checkout
    paypal_service = PaypalService.new
    @order = current_user.orders.build
    @token = paypal_service.gateway.client_token.generate
  end
end
