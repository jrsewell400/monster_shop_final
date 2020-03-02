class Discount < ApplicationRecord
  belongs_to :merchant


  validates_presence_of :name,
                        :description,
                        :discount_amt,
                        :req_qty

  validates_uniqueness_of :name, 
                          :discount_amt

  validates_inclusion_of :discount_amt, in: 0.001..0.99, message: "Discount must be between 0.001 and .99"
  validates_inclusion_of :req_qty, in: 0..999, message: "Discount must be between 0.001 and .99"
end