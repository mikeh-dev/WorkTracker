Rails.application.routes.draw do
	get 'admin/help_center', to: 'page#help_center'
	get 'admin/edit_booking', to: 'page#edit_booking'
	get 'admin/booking', to: 'page#booking'
	get 'admin/new_booking', to: 'page#new_booking'
	get 'admin/bookings', to: 'page#bookings'
	get 'admin/calendar', to: 'page#calendar'
	get 'admin/dashboard', to: 'page#dashboard'
  get '/dashboard', to: 'main#dashboard'
  
  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  root "work_orders#index"

  resources :work_orders do
    member do
      delete :remove_image
    end
  end

  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check

end