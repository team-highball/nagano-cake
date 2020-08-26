class Client::ClientsController < ApplicationController

    def top
      @genres = Genre.where(is_active: 1)
      @active_products = Product.where(is_active: 1) 
      @products = @active_products.limit(4).order('id DESC')
    end

    def about

    end

    def edit
      @client = Client.find(params[:id])
    end

    def show
        @client = current_client
    end


    def update
      @client = Client.find(params[:id])
      if @client.update(client_params)
        redirect_to client_client_path(@client)
      else
        render :edit
      end
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

    private

    def client_params
      params.
      require(:client).
      permit(:first_name,:last_name, :kana_first_name, :kana_last_name, :postal_code, :address, :phone_number, :email)
    end
end
