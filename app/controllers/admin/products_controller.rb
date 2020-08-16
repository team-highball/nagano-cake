class Admin::ProductsController < ApplicationController

    def index
        
    end

    def show
        
    end

    def new
        @product = Product.new
        @genres = Genre.all
    end

    def create
        @product = Product.new(params[:id])
        if @product.save
            redirect_to admin_product_path(params[:id])
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
        params.require(:product).permit(:name, :product_image_id, :introduction, :genre_id, :price, :status)
    end
    

end
