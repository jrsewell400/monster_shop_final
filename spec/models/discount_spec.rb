require 'rails_helper'

RSpec.describe Discount do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :discount_amt}
    it {should validate_uniqueness_of :discount_amt}
    it {should validate_presence_of :req_qty}
  end
end
