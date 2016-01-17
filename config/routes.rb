Rails.application.routes.draw do

  devise_for :users

  get 'demo_path' => 'resources#demo'

  get "/" => 'resources#home'
  get "/home" => 'resources#home'
  get "/account" => 'accounts#show'

  get '/resources' => 'resources#index'
  get '/resources/new' => 'resources#new'
  post '/resources' => 'resources#create'
  get '/resources/:id/edit' => 'resources#edit'
  get '/resources/:id/share' => 'resources#share_form'
  post '/resources/:id/share' => 'resources#share'
  get '/resources/:id' => 'resources#show'
  patch '/resources/:id' => 'resources#update'
  delete '/resources/:id' => 'resources#destroy'
  
  post '/comments' => 'comments#create'
  delete '/comments/:id' => 'comments#destroy'

  post '/comment_ratings' => 'comment_ratings#create'

  namespace :api do 
    namespace :v1 do
      
      get '/resources' => 'resources#index'
      patch '/resources/:id' => 'resources#update'
      delete '/resources/:id' => 'resources#delete'

      get '/closest_food_resource' => 'resources#find_closest_food_resource'
      get '/closest_health_resource' => 'resources#find_closest_health_resource'
      get '/closest_shelter_resource' => 'resources#find_closest_shelter_resource'

      get '/comments' => 'comments_api#index'
      post '/comments' => 'comments_api#create'
      delete '/comments/:id' => 'comments_api#destroy'

      post '/resource_ratings' => 'resource_ratings#create'

      get '/leaderboard' => 'resources#leaderboard'

    end
  end

  
end
