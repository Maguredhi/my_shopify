class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:cancel, :pay, :pay_confirm]

  def index
    @orders = current_user.orders.order(id: :desc)
  end

  def create
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      @order.order_items.build(sku_id: item.sku_id, quantity: item.quantity)
    end

    if @order.save
      # 打API
      linepay = LinepayService.new("/payments/request")
      linepay.perform({
        productName: "My_Shpoify",
        amount: current_cart.total_price.to_i,
        currency: "TWD",
        confirmUrl: "https://my-shopify-rails.herokuapp.com/orders/confirm",
        orderId: @order.num
      })

      if linepay.success?
        redirect_to linepay.payment_url
      else
        flash[:notice] = '付款發生錯誤'
        render 'carts/checkout'
      end
    end
  end

  def confirm
    linepay = LinepayService.new("/payments/#{params[:transactionId]}/confirm")
    linepay.perform({
      amount: current_cart.total_price.to_i,
      currency: "TWD"
    })

    if linepay.success?
      # 1. 變更 order 狀態
      order = current_user.orders.find_by(num: linepay.order[:order_id])
      order.pay!(transaction_id: linepay.order[:transaction_id])

      # 2. 清空購物車
      session[:cart_session] = nil
      redirect_to root_path, notice: t('cart.checkout_done')
    else
      redirect_to root_path, notice: '付款發生錯誤'
    end
  end

  def cancel
    if @order.paid?
      # 退款
      linepay = LinepayService.new("/payments/#{@order.transaction_id}/refund")
      linepay.perform(refundAmount: @order.total_price.to_i)

      if linepay.success?
        @order.cancel!
        redirect_to orders_path, notice: "訂單 #{@order.num} 已取消，並完成退款。"
      else
        redirect_to orders_path, notice: "退款發生錯誤，請聯絡客服。"
      end
      # 取消
    else
      @order.cancel!
      redirect_to orders_path, notice: "訂單 #{@order.num} 已取消。"
    end
  end

  def pay
    linepay = LinepayService.new("/payments/request")
    linepay.perform({
      productName: "My_Shpoify",
      amount: @order.total_price.to_i,
      currency: "TWD",
      confirmUrl: "https://my-shopify-rails.herokuapp.com/orders/#{@order.id}/pay_confirm",
      orderId: @order.num
    })

    if linepay.success?
      redirect_to linepay.payment_url
    else
      redirect_to orders_path, notice: '付款發生錯誤'
    end
  end

  def pay_confirm
    linepay = LinepayService.new("/payments/#{params[:transactionId]}/confirm")
    linepay.perform({
      amount: @order.total_price.to_i,
      currency: "TWD"
    })

    if linepay.success?
      @order.pay!(transaction_id: linepay.order[:transaction_id])
      redirect_to orders_path, notice: '付款已完成'
    else
      redirect_to orders_path, notice: '付款發生錯誤'
    end
  end

  private

  def find_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:recipient, :tel, :address, :note)
  end
end
