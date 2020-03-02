class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    if field_empty?
      merchant = Merchant.new(merchant_params)
      flash[:error] = "Please fill in all fields in order to create a discount."
      redirect_to new_merchant_discounts_path
    elsif merchant.save
      redirect_to '/merchants'
    else
      generate_flash(merchant)
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to "/merchants/#{@merchant.id}"
    else
      generate_flash(@merchant)
      render :edit
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    if merchant.order_items.empty?
      merchant.destroy
    else
      flash[:notice] = "#{merchant.name} can not be deleted - they have orders!"
    end
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
