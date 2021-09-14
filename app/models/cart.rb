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

  def self.from_hash(hash = nil)
    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["product_id"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end

  def serialize
    items = @items.map { |item| {"product_id" => item.product_id, 
                                 "quantity" => item.quantity} }

    { "items" => items }
  end

  def add_item(product_id)
    found = @items.find { |item| item.product_id == product_id }
    
    if found
      found.increment!
    else
      @items << CartItem.new(product_id)
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