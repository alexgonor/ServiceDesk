require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'



  end

  root to: 'tickets#index'

  scope "(:locale)", locale: /en/ do
    resources :tickets do
      resources :comments
    end
  end

  resources :tickets do
    resources :versions, only: [:destroy] do
      member do
        get :diff, to: 'versions#diff'
      end
    end
  end

  scope path: 'ticket/:id', controller: :tickets do
    put '/:status_of_ticket', to: 'tickets#resolved', status_of_ticket: /resolved/, as: :resolved
    put '/:status_of_ticket', to: 'tickets#take_in_work', status_of_ticket: /take_in_work/, as: :take_in_work
    put '/:status_of_ticket', to: 'tickets#closed', status_of_ticket: /closed/, as: :closed
  end

  get '/:locale' => 'tickets#index'

  mount ActionCable.server => '/cable'
  
end
