class Public::ShippingAddressesController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses
  end
  
  def create
    @shipping_address = ShippingAddress.new(shipping_addresses_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      redirect_to shipping_addresses_path(@shipping_address.id)
    else
      @shipping_addresses = current_customer.shipping_addresses
      render :index
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end
  
  def update
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.update(shipping_addresses_params)
    if @shipping_address.save
      redirect_to shipping_addresses_path
    else
      render :edit
    end
  end
  
  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_addresses_path
  end
  
  private
  
  def shipping_addresses_params
    params.require(:shipping_address).permit(:postal_code, :address, :name ,:customer_id)
  end
end
