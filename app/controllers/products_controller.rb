class ProductsController < ApplicationController
  def index
    @products = Product.all.order(updated_at: :desc).includes(:vendor)
  end

  def show
  end
end
