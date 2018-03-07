Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'tickets#index'

  scope "(:locale)", locale: /en/ do
    resources :tickets do
      resources :comments
    end
  end

  get '/:locale' => 'tickets#index'

end
