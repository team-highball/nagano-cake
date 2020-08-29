class Client::ProductsController < ApplicationController

  before_action :active_genres, only: [:index]
  before_action :active_products, only: [:show]


    def index
      @genres = Genre.where(is_active: 1)
      if params[:genre_sort] == "0" || params[:genre_sort] == nil
        if params[:keyword] == "1"
          @products = Product.where(is_active: 1).order(price: "DESC").page(params[:page]).per(12)
        elsif params[:keyword] == "2"
          @products = Product.where(is_active: 1).order(price: "ASC").page(params[:page]).per(12)
        elsif params[:keyword] == "3"
          @products = Product.where(is_active: 1).order(updated_at: "DESC").page(params[:page]).per(12)
        else
        @products = Product.where(is_active: 1).page(params[:page]).per(12)
      end
      else
        @products = Product.where(genre_id: params[:genre_sort].to_i,is_active: 1).page(params[:page]).per(12)
        genre = Genre.find_by(id: params[:genre_sort].to_i)
        @genre_name = genre.name
      end
    end


    def show
      @genres = Genre.where(is_active: 1)
      @product = Product.find(params[:id])
      @tax_price = @product.price
      @cart_product = CartProduct.new
    end

    private

    def active_genres
      if params[:genre_sort] == "0" || params[:genre_sort] == nil
      else
        before_genre = Genre.find_by(id: params[:genre_sort])
        redirect_to client_products_path if before_genre.is_active == 0
      end
    end


    def active_products
      product = Product.find(params[:id])
      redirect_to client_products_path if product.is_active == 2
    end


end
