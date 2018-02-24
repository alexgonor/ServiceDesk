Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tickets#index'
  scope "(:locale)", locale: /en/ do
    resources :tickets, only: [:index]
  end

  get '/:locale' => 'tickets#index'

  devise_scope :user do
    root to: "devise/sessions#new"
  end
end
