Rails.application.routes.draw do
  resources :rovers, only: [:new, :show] do
    match ':movement', to: 'movements#create', format: :json,
          constraints: { movement: /(move_forwards|move_backwards|turn_left|turn_right)/ },
          via: :post,
          as: 'movements'
  end
end
