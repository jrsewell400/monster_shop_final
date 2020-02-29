class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name,
                        :description,
                        :discount_amt,
                        :req_qty

end