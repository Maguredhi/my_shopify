# PORO = Plain Old Ruby Object 無任何繼承，主要是用來做某些服務
class Cart
  attr_reader :items
  # 等同於
  #def items
  #  @items
  #end

  def initialize
    @items = []
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
end