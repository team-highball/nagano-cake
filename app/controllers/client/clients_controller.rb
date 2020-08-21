class Client::ClientsController < ApplicationController

    def top
    @genres = Genre.where(is_active: 1)
    @products = Product.limit(4)

    end

    def about

    end

    def show
        @client = current_client
    end


    def update

    end

    def withdrawal


    end

end
