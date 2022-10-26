Rails.application.routes.draw do
  get 'main/login'
  post 'main/create'
  get 'main/destroy'
  resources :users
  resources :scores
  resources :students
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'students/:id/edit_score', to: 'students#edit_score', as: 'students_edit_score'
  #post 'students/edit', to: 'students#edit'
  # Defines the root path route ("/")
  # root "articles#index"
end
