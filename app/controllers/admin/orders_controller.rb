class Admin::OrdersController < ApplicationController

    before_action :authenticate_admin!

    def index
        case params[:order_sort]
            when "0"
                @orders = Order.where(created_at: Time.zone.now.all_day)
            when "1"
                @client = Client.find(params[:id])
                @orders = @client.orders
            else
                @orders = Order.all
        end
    end

    def show
        @order = Order.find(params[:id])
        @client = Client.find(@order.client_id)
        @order_products = @order.order_products
    end

    def update
        @order = Order.find(params[:id])
        if @order.update(order_params)
            redirect_back(fallback_location: root_path)
        else
            render "show"
        end
        
    end

    private

    def order_params
        params.require(:order).permit(:status)
    end

end
