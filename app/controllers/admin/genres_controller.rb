class Admin::GenresController < ApplicationController

    def create
        
    end

    def index
        @genre = Genre.new
        @genres = Genre.all
    end

    def edit
        
    end
    
    def destroy
        
    end

    private

    def genre_params
        params.require(:genre).permit(:name, :is_active)
    end
    
end
