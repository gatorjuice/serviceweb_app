Rails.application.routes.draw do
  
  devise_for :users
  get "/" => 'resources#home'
  get "/home" => 'resources#home'

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

  namespace :api do 
    get '/comments' => 'comments_api#index'
    delete '/comments' => 'comments_api#destroy'

    namespace :v1 do
      get '/resources' => 'resources#index'
      patch '/resources/:id' => 'resources#update'
      delete '/resources/:id' => 'resources#delete'
    end
  end

  post '/comment_ratings/' => 'comment_ratings#create'
  
end
