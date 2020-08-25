class Admin::GenresController < ApplicationController

    before_action :authenticate_admin!

    def index
        @genre = Genre.new
        @genres = Genre.all
    end

    def create
        @genre = Genre.new(genre_params)
        if @genre.save
            redirect_back(fallback_location: root_path)
        else
            @genres = Genre.all
            render "index"
        end

    end

    def edit
        @genre = Genre.find(params[:id])
    end

    def update
        @genre = Genre.find(params[:id])
        if @genre.update(genre_params)
            if @genre.is_active == 0
                @products = @genre.products
                @products.each do |product|
                    product.is_active = 2
                    product.update(product_params)
                end
            end
            redirect_to admin_genres_path
        else
            render "edit"
        end
    end


    private

    def genre_params
        params.require(:genre).permit(:name, :is_active)
    end

    def product_params
        params.permit(:is_active)
    end
    

end
