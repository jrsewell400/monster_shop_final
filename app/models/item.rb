class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name, :description, :image, :price, :inventory

  def self.active_items
    where(active: true)
  end

  def self.by_popularity(limit = nil, order = "DESC")
    left_joins(:order_items)
    .select('items.id, items.name, COALESCE(sum(order_items.quantity), 0) AS total_sold')
    .group(:id)
    .order("total_sold #{order}")
    .limit(limit)
  end

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def apply_discount?(qty)
    !merchant.discounts.where("#{qty} >= discounts.req_qty").empty?
  end

  def merchant_discount(qty)
    merchant.discounts.where("#{qty} >= discounts.req_qty").order(discount_amt: :desc).first.discount_amt
  end

  def discount_price(qty)
    (price * qty) - ((price * merchant_discount(qty)) * qty)
  end

  def discount_order_price(qty)
    price - (price * merchant_discount(qty))
  end 
end
