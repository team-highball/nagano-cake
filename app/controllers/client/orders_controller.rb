class Client::OrdersController < ApplicationController


  # private以下で @client = current_client のアクション
  before_action :set_client

  def index
    @orders = @client.orders
  end

  def show
    @order = Order.find(params[:id])
    if @order.client_id != current_client.id
      redirect_back(fallback_location: root_path)
      flash[:alert] = "アクセスに失敗しました"
    end
  end


  def new
    current_client_cart = current_client.cart_products
    if current_client_cart.blank?
      redirect_to client_cart_products_path(current_client)
    else
      @order = Order.new
    end
  end


  def confirm
    @order = Order.new
    @cart_products = current_client.cart_products
    @order.payment_method = params[:order][:payment_method]

    # 合計金額を求める
    sum_all = 0
    @cart_products.each do |cp|
      sum_product = price_include_tax(cp.product.price).to_i * cp.count
      sum_all += sum_product
    end
    @order.total_bill = sum_all + @order.postage

    # どのラジオボタンを押したかを数字で渡す
    @add = params[:order][:add].to_i
    case @add
      # 自分の住所
    when 1
      @order.postal_code   = @client.postal_code
      @order.address       = @client.address
      @order.name          = @client.last_name + @client.first_name
     # 登録済住所
    when 2
    @sta = params[:order][:address].to_i
      if @sta == 0
        render "new"
      elsif
        @shipping_address = ShippingAddress.find(@sta)
        @order.postal_code     = @shipping_address.postal_code
        @order.address         = @shipping_address.address
        @order.name            = @shipping_address.destination
     end

     # 入力された新しい住所
    when 3
    if params[:order][:new_add][:postal_code].blank? || params[:order][:new_add][:address].blank? || params[:order][:new_add][:destination].blank?
      render :new
    else
      @order.postal_code        = params[:order][:new_add][:postal_code]
      @order.address            = params[:order][:new_add][:address]
      @order.name               = params[:order][:new_add][:destination]
    end
   end
  end


  def create

    if current_client.cart_products.exists?

      @order = Order.new(order_params)
      @order.client_id = current_client.id
      @order.payment_method = params[:order][:payment_method]

      # 合計金額を求める
      sum_all = 0
      cart_product = current_client.cart_products
      cart_product.each do |cp|
        sum_product = price_include_tax(cp.product.price).to_i * cp.count
        sum_all += sum_product
      end
      @order.total_bill = sum_all + @order.postage


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
          @order.postal_code            = params[:order][:postal_code]
          @order.address                = params[:order][:address]
          @order.name                   = params[:order][:name]
          # @orderの内容をshiping_addressに新規登録
          shipping_address = current_client.shipping_addresses.build
          shipping_address.address      = @order.address
          shipping_address.destination  = @order.name
          shipping_address.postal_code  = @order.postal_code
          shipping_address.save
      end
      @order.save!

      # cart_productsの内容をorder_productsに新規登録
      current_client.cart_products.each do |cp|
        order_products              = @order.order_products.build
        order_products.order_id     = @order.id
        order_products.product_id   = cp.product_id
        order_products.price        = price_include_tax(cp.product.price)
        order_products.count        = cp.count
        order_products.save
        cp.destroy
      end

      render :thanks

    else
      redirect_to client_products_path(genre_sort: 0)
      flash[:danger] = 'カートが空です。'
    end

  end



  def thanks
  end


  private


  def set_client
    @client = current_client
  end



  def order_params
    # 注文の際の注文商品も保存するようにする
    params.require(:order).permit(
      :status, :postal_code, :address, :name, :postage, :total_bill, :payment_method,
      order_products_attributes: [:order_id, :product_id, :price, :count, :making_status]
    )
  end

end
