require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => { registrations: 'registrations' }

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'tickets#index'

  scope "(:locale)", locale: /en/ do
    resources :tickets do
      resources :comments
    end
  end

  get '/:locale' => 'tickets#index'

end
