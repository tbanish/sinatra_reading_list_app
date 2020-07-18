class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_dir, "public"
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect to "/users"
    end
  end

  post '/users' do
    if !User.find_by(username: params[:username]) && params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/users"
    else
      redirect to "/signup"
    end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect to "/users"
    end
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

  get '/logout' do
    if logged_in?
      erb :logout
    else
      redirect to "/login"
    end
  end

  post '/logout' do
    session.clear
    redirect to "/login"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:id])
    end
  end
end
