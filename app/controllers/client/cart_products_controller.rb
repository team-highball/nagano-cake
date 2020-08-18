class Client::CartProductsController < ApplicationController

    def index
        @cart_products = CartProduct.all
        Product.all.sum(:price)
    end

    def create
        
    end

    def update
        
    end
    
    def destroy
        
    end
    
    def destroy_all
        
    end
    
end
