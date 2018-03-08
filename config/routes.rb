Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'tickets#index'

  scope "(:locale)", locale: /en/ do
    resources :users, only: [:index]
    resources :tickets, except: :show
  end

  get '/:locale' => 'tickets#index'


end
