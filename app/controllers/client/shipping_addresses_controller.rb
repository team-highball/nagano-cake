class Client::ShippingAddressesController < ApplicationController

    def index
        @shipping_address   = ShippingAddress.new
        @shipping_addresses = ShippingAddress.where(client_id: current_client.id)
    end

    def edit
        @shipping_address = ShippingAddress.find(params[:id])
    end

    def create
        #アソシエーション未実装
        @shipping_address = ShippingAddress.new(shipping_address_params)
        @shipping_address.client_id = current_client.id
        @shipping_address.phone_number = current_client.phone_number
        if @shipping_address.save
            redirect_to client_shipping_addresses_path
        else
            render "index"
        end
        
    end
    
    def update
        @shipping_address = ShippingAddress.find(params[:id])
        if @shipping_address.update(shipping_address_params)
            redirect_to client_shipping_addresses_path
        else
            render "edit"
        end
    end
    
    def destroy
        @shipping_address = ShippingAddress.find(params[:id])
        @shipping_address.destroy
        redirect_to client_shipping_addresses_path
    end

    private

    def shipping_address_params
        params.require(:shipping_address).permit(:postal_code, :destination, :address)
    end
    
end
