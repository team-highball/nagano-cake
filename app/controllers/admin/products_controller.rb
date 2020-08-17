class Admin::ProductsController < ApplicationController

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
        
    end
    
    def update
        
    end
    
    def destroy
        
    end

    private

    def product_params
        params.require(:product).permit(:name, :product_image, :introduction, :genre_id, :price, :status)
    end
    

end
