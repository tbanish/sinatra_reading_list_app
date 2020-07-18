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
    if User.find_by(username: params[:username])
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/users"
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users"
    else
      redirect "/login"
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(session[:id])
    end


  end


end
