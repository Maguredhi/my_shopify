class CartItem
  attr_reader :sku_id, :quantity, :product_id

  def initialize(sku_id, quantity = 1, product_id)
    @sku_id = sku_id
    @quantity = quantity.to_i
    @product_id = product_id
  end

  def increment!(n = 1)
    @quantity += n
  end

  def product
    # Product.friendly.find(sku_id)
    Product.joins(:skus).find_by(skus: { id: sku_id })
  end

  def total_price
    product.sell_price * @quantity
  end
end
