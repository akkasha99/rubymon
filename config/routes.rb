Rails.application.routes.draw do
  devise_for :users, :controllers => {
                       :sessions => "users/sessions",
                       :confirmations => "users/confirmations",
                       :passwords => "users/passwords",
                       :unlocks => "users/unlocks",
                       :omniauth => "users/omniauth_callbacks",
                       :registrations => "users/registrations"
                   }
  devise_scope :user do
    get 'facebook_sign_up', :to => "users/registrations#facebook_sign_up"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      get 'create'
    end
  end

  resources :monsters do
    collection do
      get 'create'
    end
  end
end
