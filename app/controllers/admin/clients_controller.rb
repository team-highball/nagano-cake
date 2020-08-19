class Admin::ClientsController < ApplicationController

    before_action :authenticate_admin!

    def index
        @clients = Client.all
    end

    def show
        @client = Client.find(params[:id])
    end

    def edit
        @client = Client.find(params[:id])
    end

    def update
        @client = Client.find(params[:id])
        if @client.update(client_params)
            redirect_to admin_client_path(@client.id)
        else
            render "edit"
        end
    end

    private

    def client_params
        params.require(:client).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number, :email, :deleted_user)
    end

end
