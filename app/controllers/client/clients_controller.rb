class Client::ClientsController < ApplicationController

    def top
        @products = Product.limit(4)
    end

    def about
        
    end

    def show
        @client = current_client
    end
    
    def withdrawal
        
    end

end
