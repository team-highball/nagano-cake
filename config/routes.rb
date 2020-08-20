Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'client/clients#top'

  devise_for :admins, controllers: {
        sessions:      'admins/sessions',
        passwords:     'admins/passwords',
        registrations: 'admins/registrations'
    }

    devise_for :clients, controllers: {
        sessions:      'clients/sessions',
        passwords:     'clients/passwords',
        registrations: 'clients/registrations'
    }


    namespace :client do
        get "clients/top" => "clients#top"
        get "clients/about" => "clients#about"
        get "clients/withdrawal" => "clients#withdrawal"
        patch "clients" => "clients#update"
        resources :products, only: [:index, :show]
        resources :clients, only: [:show]
        resources :cart_products, only: [:create, :update, :destroy, :index]
        delete "cart_products" => "cart_products#destroy_all"
        get "orders/confirm" => "orders#confirm"
        get "orders/thanks" => "orders#thanks"
        resources :orders, only: [:new, :create, :index, :show,]
        resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
    end

    namespace :admin do
        get "admins/top" => "admins#top"
        resources :products, :except => [:destroy]
        resources :genres, only: [:create, :index, :edit, :update]
        resources :clients, only: [:index, :show, :edit, :update]
        resources :orders, only: [:update, :index, :show] do
            resources :order_prducts, only: [:update]
        end
    end

end
