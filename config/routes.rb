Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # parking
  get '/parking/:plate' => 'parking#show'
  post '/parking' => 'parking#create'
  put 'parking/:id/pay' => 'parking#pay'
  put 'parking/:id/out' => 'parking#out'
end
