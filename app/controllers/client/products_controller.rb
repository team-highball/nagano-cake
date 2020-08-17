class Client::ProductsController < ApplicationController

    def index
      @products = Product.all
    end

    def show
      @product = Product.find(params[:id])
      @tax_price = @product.price
      # taxメソッドは後々追加
      @tax_included_price = @tax_price
    end

end
