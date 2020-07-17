class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_dir, "public"
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/signup' do
    erb :signup
  end

  post '/users' do
  end

  get '/login' do
    erb :login
  end

  post '/login' do
  end


end
