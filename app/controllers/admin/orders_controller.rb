class Admin::OrdersController < ApplicationController

    before_action :authenticate_admin!

    def empty_search(search, option)
        @status = option.to_i
        @orders = Order.where(status: @status)
        if search.blank?
            @orders = Order.where(status: @status)
        else
            @orders = @orders.where("(status LIKE ?) AND (address LIKE ?) OR (postal_code LIKE ?) OR  (name LIKE ?)",@status,"%#{search}%","%#{search}%","%#{search}%")
        end
    end

    def index
        case params[:order_sort]
            when "0"
                @orders = Order.where(created_at: Time.zone.now.all_day)
            when "1"
                @client = Client.find(params[:id])
                @orders = @client.orders
            else
                if params[:option] == nil
                    @orders = Order.all
                elsif params[:option] == "0"
                    if params[:search].blank?
                        @orders = Order.all
                    else
                        @orders = Order.where("(postal_code LIKE ?) OR (address LIKE ?) OR (name LIKE ?)","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")
                    end
                else
                    empty_search(params[:search], params[:option])
                end
        end
    end

    def show
        @order = Order.find(params[:id])
        @client = Client.find(@order.client_id)
        @order_products = @order.order_products
    end

    def update
        @order = Order.find(params[:id])
        @orders = @order.order_products
        if @order.update(order_params)
            if @order.status == 2
                @order.order_products.each do |order_product|
                    order_product.making_status = 2
                    order_product.update(order_product_params)
                end
            end
            redirect_back(fallback_location: root_path)
        else
            render "show"
        end
        
    end

    private

    def order_params
        params.require(:order).permit(:status)
    end

    def order_product_params
        params.permit(:making_status)
    end

end
