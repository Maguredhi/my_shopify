class Api::V1::UtilsController < ApplicationController
  def subscribe
    email = params['subscribe']['email']
    sub = Subscribe.new(email: email)

    if sub.save
      render json: { status: 'ok', email: email }
    else
      render json: { status: 'duplicated', email: email }
    end
  end

  def cart
    # product = Product.friendly.find(params[:id])
    product = Product.joins(:skus).find_by(skus: { id: params[:sku] })

    if product
      current_cart.add_product(params[:sku], params[:quantity], product.id)
      session[:cart_session] = current_cart.serialize

      render json: { status: 'ok', items: current_cart.items.count, quantity: params[:quantity] }
    end
    # render json: params
  end
end
