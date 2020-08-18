class Client::OrdersController < ApplicationController


    # private以下で @client = current_client のアクション
    before_action :set_client

    def index

    end

    def show
      @order = Order.find(params[:id])
    end


    def new
      @order = Order.new
    end



    def create

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
          order_products              = @order.order_products.build
          order_products.order_id     = @order.id
          order_products.product_id   = cart_products.product_id
          order_products.price        = cart_products.product.price
          order_products.count        = cart_products.product.count
          order_products.save
          cart_products.destroy
        end
        render :thanks

      else
        redirect_to client_products_path
        flash[:danger] = 'カートが空です。'
      end

    end



    def confirm
      @order = Order.new
      # @cart_products = current_client.cart_products
      @order.status = params[:order][:status]
      # どのラジオボタンを押したかを数字で渡す
      @add = params[:order][:add].to_i
      case @add
        # 自分の住所
      when 1
        @order.postal_code   = @client.postal_code
        @order.address       = @client.address
        @order.name          = @client.first_name + @client.last_name
       # 登録済住所
      when 2
       @sta = params[:order][:address].to_i
       @shipping_address = ShippingAddress.find(@sta)
       @order.postal_code     = @shipping_address.postal_code
       @order.address         = @shipping_address.address
       @order.name            = @shipping_address.destination
       # 入力された新しい住所
      when 3
       @order.postal_code     = params[:order][:new_add][:post_code]
       @order.address         = params[:order][:new_add][:address]
       @order.name            = params[:order][:new_add][:destination]
     end
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
