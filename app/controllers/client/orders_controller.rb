class Client::OrdersController < ApplicationController

    def index

    end

    def show

    end


    def new
      @order = Order.new
    end

    def create
      @order = Order.new(order_params)
      @order.client_id = current_user.id
      @order.save
      redirect_to client_orders_thanks_path
    end

    def thanks

    end

    private

    def order_params
      params.require(:order).permit(:status, :postal_code, :address, :name, :status)
    end

end
