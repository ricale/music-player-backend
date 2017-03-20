Rails.application.routes.draw do
  resources :albums
  resources :artists
  # constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :musics
      end
    end
  # end
end
