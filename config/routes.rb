Rails.application.routes.draw do
  # constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :album_artists
        resources :albums
        resources :artists
        resources :musics
      end
    end
  # end
end
