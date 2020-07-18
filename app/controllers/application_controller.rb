require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_dir, "public"
    use Rack::Flash
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
      flash[:notice] = "You are already signed up."
      redirect to "/users"
    end
  end

  post '/users' do
    if User.find_by(username: params[:username])
      flash[:notice] = "This username has already been taken."
      redirect to "/signup"
    elsif params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:id] = @user.id
      flash[:notice] = "Successfully Signed Up."
      redirect to "/users"
    else
      flash[:notice] = "Please make sure all fields are filled out."
      redirect to "/signup"
    end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      flash[:notice] = "You are already logged in."
      redirect to "/users"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect "/users"
    else
      flash[:notice] = "The username and password you entered do not match our records."
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      erb :logout
    else
      flash[:notice] = "You are not logged in."
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
