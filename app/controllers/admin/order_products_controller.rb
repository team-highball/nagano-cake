class Admin::OrderProductsController < ApplicationController

    before_action :authenticate_admin!

    def update
        @order_product = OrderProduct.find(params[:id])
    end

    private

    def order_params
        params.require(:order).permit(:status)
    end

end
