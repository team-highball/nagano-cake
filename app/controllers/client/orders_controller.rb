class Client::OrdersController < ApplicationController


    # private以下で @client = current_client のアクション
    before_action :set_client

    def index

    end

    def show

    end


    def new
      @order = Order.new
    end

    def confirm
      if current_client.cart_products.exists?
        @order = Order.new(order_params)
        @order.client_id = current_client.id

        # どのラジオボタンを押したかを数字で渡す
        @add = params[:order][:add].to_i
        case @add
          # 自分の住所
          when 1
            @order.postal_code = @client.postal_code
            @order.address = @client.address
            @order.name = @client.first_name + @client.last_name
          # 登録済住所
          when 2
            @order.postal_code = params[:order][:postal_code]
            @order.address = params[:order][:address]
            @order.name = params[:order][:name]
           # 新しいお届け先
          when 3
            @order.postal_code = params[:order][:postal_code]
            @order.address = params[:order][:address]
            @order.name = params[:order][:name]
        end
        @order.save

        # cart_productsの内容をorder_productsに新規登録
        current_client.cart_products.each do |cp|
          

    end

    def create

    end

    def thanks

    end

    private

    def set_client
      @client = current_client
    end

    def order_params
      params.require(:order).permit(:status, :postal_code, :address, :name)
    end

end
