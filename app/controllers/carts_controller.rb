class CartsController < ApplicationController
  # 有登入才可以進來這 controller
  before_action :authenticate_user!
  helper_method :find_sku

  def payment
  end

  def show
  end

  def destroy
    session[:cart_session] = nil
    redirect_to root_path, notice: t('notice.clear_cart_message')
  end

  def checkout
    @order = current_user.orders.build
    @token = gateway.client_token.generate
  end

  def find_sku(sku_id)
    Sku.find(sku_id)
  end

  private

  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV['braintree_merchant_id'],
      public_key: ENV['braintree_public_key'],
      private_key: ENV['braintree_private_key'],
    )
  end
end
