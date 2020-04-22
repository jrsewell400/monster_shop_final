class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    item_qty = Hash.new(0)
    @contents.each do |item_id, qty|
      item_qty[Item.find(item_id)] = qty
    end
    item_qty
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, qty|
      item = Item.find(item_id)
      if item.apply_discount?(qty)
        grand_total += item.discount_price(qty)
      else
        grand_total += item.price * qty
      end
    end
    grand_total
  end
  
  def count_of(item_id)
    @contents[item_id.to_s]
  end
  
  def subtotal_of(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end
  
  def discount_subtotal(item)
    subtotal_of(item.id) - ((subtotal_of(item.id)) * (item.merchant_discount(@contents[item.id.to_s])))
  end
  
  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end
end

# sub = (item.price * @contents[item.id.to_s])
# subtotal = subtotal * item.merchant_discount(@contents[item.id.to_s])