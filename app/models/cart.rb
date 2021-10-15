# PORO = Plain Old Ruby Object 無任何繼承，主要是用來做某些服務
class Cart
  attr_reader :items
  # 等同於
  #def items
  #  @items
  #end

  def initialize(items = [])
    @items = items
  end

  # 檢查目前購物車內是否有商品
  def self.from_hash(hash = nil)
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["sku_id"], item["quantity"], item["product_id"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end

  def serialize
    items = @items.map { |item| {"sku_id" => item.sku_id, 
                                 "quantity" => item.quantity,
                                 "product_id" => item.product_id} }

    { "items" => items }
  end

  def add_product(sku_id, quantity, product_id)
    found = @items.find { |item| item.sku_id == sku_id }
    
    if found
      found.increment!
    else
      @items << CartItem.new(sku_id, quantity, product_id)
    end
  end

  def empty?
    @items.empty?
  end

  def total_price
    # total = 0

    # @items.each do |item|
    #   total += item.total_price
    # end

    # total
    @items.reduce(0) { |sum, item| sum + item.total_price }
  end
end
