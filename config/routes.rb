Rails.application.routes.draw do

      # 顧客用
    # URL /customers/sign_in ...
    devise_for :customers, skip: [:passwords],controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }

    scope module: :public do
    	root to:"homes#top"
      get "about"=>"homes#about",as:"about"
    end

    #public/customers
    scope module: :public do
      get 'customers/my_page' => 'customers#show', as: 'my_page'
      get 'customers/information/edit' => 'customers#edit'
      patch 'customers/information' => 'customers#update', as: 'information'

      get 'customers/confirm' => "customers#confirm", as: 'confirm' #退会確認ページ
      patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw' #退会処理
    end

    scope module: :public do
      delete "cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all" #「resources:cart_items」の上にdestroy_allを持ってきたらidがつかない
      resources:cart_items, only: [:index,:update,:destroy,:create] 
      resources :shipping_addresses
      resources :items
      resources :shops
    end



    # 管理者用
    # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }

    namespace :admin do
      resources :genres
      resources :items
      resources :shops
      resources :customers
    end

end
