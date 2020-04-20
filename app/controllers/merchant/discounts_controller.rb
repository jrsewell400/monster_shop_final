class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = current_user.merchant.discounts
  end
  
  def show 
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def create
    @merchant = current_user.merchant
    @discount = @merchant.discounts.new(discount_params)
    if field_empty?
      discount = Discount.new(discount_params)
      flash[:error] = "Please fill in all fields in order to create a discount."
      redirect_to new_merchant_discount_path
    elsif @discount.save
      redirect_to merchant_discounts_path
    else
      generate_flash(@discount)
      render :new
    end
  end

  def destroy
    discount = Discount.find(params[:id]).destroy
    flash[:success] = "#{discount.name} has been removed from discounts."
    redirect_to merchant_discounts_path
  end

  def edit 
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
      redirect_to merchant_discounts_path
    else 
      generate_flash(discount)
      render :edit
    end 
  end 

  private

  def discount_params
    params.permit(:name, :description, :discount_amt, :req_qty)
  end

  def field_empty?
    params = discount_params
    params[:name].empty? || params[:description].empty? || params[:discount_amt].empty? || params[:req_qty].empty?
  end
end 
