class Client::CartProductsController < ApplicationController
    before_action :authenticate_client!
    before_action :set_cart_product, only: [:show, :update, :destroy, :edit]
    before_action :set_client

#カート内商品一覧
    def index
        @cart_products = @client.cart_products.all
        # @product = Product.find(params[:cart_product][:product_id])
    end

    def create
        @product = Product.find(params[:cart_product][:product_id])
        @cart_product = current_client.cart_products.new(cart_product_params)
    # カートに現在入っている商品　＝　カートに入っている商品IDと顧客が選んだ商品のIDが合致している商品
        @current_product = CartProduct.find_by(product_id: @cart_product.product_id,client_id: @cart_product.client_id)
        # binding.pry
    # カートに同じ商品がなければ新規追加、あれば既存のデータと合算
    if @current_product.nil?
        if @cart_product.count.blank?
            @cart_product.count = 1
        end
      if @cart_product.save
        flash[:success] = 'カートに商品が追加されました'
        redirect_to client_cart_products_path
      else
        @cart_products = @client.cart_products.all
        flash[:danger] = 'カートに商品を追加できませんでした。'
        render 'index'
      end
#カート内が空でない場合
    else
        if @cart_product.count.blank?
            @cart_product.count = 0
        end
#paramsで取得した値は文字列になってしまうので、to_iで整数化させる事が必要
      @current_product.count += @cart_product.count
#カート内商品の数量を更新した上で、カート内商品一覧画面へ遷移
      @current_product.update(c_product_params)
      redirect_to client_cart_products_path
      end
    end

    def update
        # if @cart_product.update(cart_product_params)
        @cart_products = current_client.cart_products.all
        if @cart_product.update(cart_product_params)
        flash[:success] = 'カート内の商品を更新しました'
        #redirect_to client_cart_products_path
        end
    end

    def destroy
        @cart_products = current_client.cart_products.all
        @cart_product.destroy
        flash[:info] = 'カートの商品を取り消しました。'
        #redirect_to client_cart_products_path
    end

    def destroy_all
        @cart_products = current_client.cart_products.all
        @client.cart_products.destroy_all
        flash[:info] = 'カートを空にしました。'
        #redirect_to client_cart_products_path
    end

    private
    def set_client
        @client = current_client
    end

    def set_cart_product
        @cart_product = CartProduct.find(params[:id])
    end

    def cart_product_params
        params.require(:cart_product).permit(:product_id, :client_id, :count)
    end

    def c_product_params
        params.permit(:count)
    end

end
