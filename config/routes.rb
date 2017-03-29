Rails.application.routes.draw do
  # constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :musics
        resources :albums
        resources :artists
      end
    end
  # end
end
