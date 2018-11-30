Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root 'dashboards#show'
    get '' => 'dashboard#show', as: 'dashboard'
  end
  root 'homes#show'
  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, only: [:create]

  resources :users, only: %i[create show] do
    resource :password,
      controller: 'clearance/passwords',
      only: %i[create edit update]

    member do
      post :follow, to: 'relations#follow'
      delete :unfollow, to: 'relations#unfollow'
    end

    resources :followers, only: :index
  end

  post 'text_shouts' => 'shouts#create', default: { content_type: TextShout }
  post 'photo_shouts' => 'shouts#create', default: { content_type: PhotoShout }
  resources :shouts, only: [:show] do
    member do
      post :like, to: 'likes#create'
      delete :unlike, to: 'likes#destroy'
    end
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
