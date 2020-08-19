class Admin::ProductsController < ApplicationController

    before_action :authenticate_admin!

    def index
        @products = Product.all

    end

    def show
        @product = Product.find(params[:id])
        @genre = Genre.find(@product.genre_id)
        if @product.is_active == 1
            @product_status = "販売中"
        else
            @product_status = "販売停止中"
        end
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            redirect_to admin_product_path(@product.id)
        else
            render "new"
        end
    end


    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            redirect_to admin_product_path(@product.id)
        else
            render "edit"
        end
    end

    def destroy

    end

    private

    def product_params
        params.require(:product).permit(:name, :product_image, :introduction, :genre_id, :price, :is_active)
    end


end
