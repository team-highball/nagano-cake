class Client::CartProductsController < ApplicationController
    before_action :authenticate_client!
    before_action :set_cart_product, only: [:show, :update, :destroy, :edit]
    before_action :set_client

#カート内商品一覧
    def index
        @cart_products = @client.cart_products.all
        # @product = Product.find(params[:cart_product][:product_id])
        @sub_prices = CartProduct.all.sum(:price)
    end

    def create
        @product = Product.find(params[:cart_product][:product_id])
        @cart_product = current_client.cart_products.new(cart_product_params)
    # カートに現在入っている商品　＝　カートに入っている商品IDと顧客が選んだ商品のIDが合致している商品
        @current_product = CartProduct.find_by(product_id: @cart_product.product_id,client_id: @cart_product.client_id)
        # binding.pry
    # カートに同じ商品がなければ新規追加、あれば既存のデータと合算
    if @current_product.nil?
      if @cart_product.save
        flash[:success] = 'カートに商品が追加されました'
        redirect_to client_cart_products_path
      else
        @cart_products = @client.cart_products.all
        render 'index'
        flash[:danger] = 'カートに商品を追加できませんでした。'
      end
#カート内が空でない場合
    else
#paramsで取得した値は文字列になってしまうので、to_iで整数化させる事が必要
      @current_product.count += params[:count].to_i
#カート内商品の数量を更新した上で、カート内商品一覧画面へ遷移
      @current_product.update(cart_product_params)
      redirect_to client_cart_products_path
      end
    end

    def update
        if @cart_product.update(cart_product_params)
        redirect_to client_cart_products_path
        flash[:success] = 'カート内の商品を更新しました'
        end
    end

    def destroy
        @cart_product.destroy
        redirect_to client_cart_products_path
        flash[:info] = 'カートの商品を取り消しました。'
    end

    def destroy_all
         @client.cart_products.destroy_all
        redirect_to client_cart_products_path
        flash[:info] = 'カートを空にしました。'
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

end
