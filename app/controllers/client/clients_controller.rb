class Client::ClientsController < ApplicationController

    def top
    @genres = Genre.where(is_active: 1)
    @products = Product.limit(4).order('id DESC')
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

    def withdraw_done
    @client = current_client
    @client.update(deleted_user: 0)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

end
