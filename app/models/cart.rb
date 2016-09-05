class Cart

  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(product_id)
    item = @items.find { |item| item.product_id == product_id}
    if item
      item.increment
    else
      @items << CartItem.new(product_id)
    end
  end

  def empty?
    @items.empty?
  end

  def serialize
    hash = @items.map do |item|
      {
        "product_id" => item.product_id,
        "quantity" => item.quantity
      }
    end
    {
        "items" => hash
    }
  end

  def count
    @items.length
  end

  def self.builds_from_hash(hash)
    items =
      if hash["cart"] then
        hash["cart"]["items"].map do |item_data|
        CartItem.new(item_data["product_id"], item_data["quantity"])
        end
      else
        []
      end
    Cart.new(items)
  end

  def total_price
    @items.inject(0) {|sum, item| sum + item.total_price}
  end
end
