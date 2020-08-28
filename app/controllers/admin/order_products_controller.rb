class Admin::OrderProductsController < ApplicationController

    before_action :authenticate_admin!

    def update
        @order_product = OrderProduct.find(params[:id])
        @order = Order.find(@order_product.order_id)
        @client = Client.find(@order.client_id)
        @order_products = @order.order_products
        @making_order_products = OrderProduct.where(order_id: @order.id, making_status: 3) 
        if @order_product.update(order_product_params)
            if @order_product.making_status == 3
                if @making_order_products.present?
                    @order.status = 3
                    @order.update(product_params)
                end
            elsif @order_product.making_status == 4
                @maked_order_products = OrderProduct.where(order_id: @order.id, making_status: 4)
                if @order_products.count == @maked_order_products.count
                    @order.status = 4
                    @order.update(product_params)
                end
            end
        else
            render "admin/orders#show"
        end
    end

    private

    def order_product_params
        params.require(:order_product).permit(:making_status)
    end

    def product_params
        params.permit(:status)
    end

end
