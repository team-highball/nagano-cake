class Client::ProductsController < ApplicationController

    def index
      @genres = Genre.all
      if params[:genre_sort] == "0"
        @products = Product.all
      elsif
        @products = Product.where(genre_id: params[:genre_sort].to_i)
        genre = Genre.find_by(id: params[:genre_sort].to_i)
        @genre_name = genre.name
      end
    end

    def show
      @genres = Genre.all
      @product = Product.find(params[:id])
      @tax_price = @product.price
      @cart_product = CartProduct.new
    end

end
