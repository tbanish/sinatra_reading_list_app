class UsersController < ApplicationController
  get '/users' do
    if logged_in?
      erb :"/users/index"
    else
      flash[:notice] = "You need to log in first to view your page."
      redirect to "/login"
    end
  end
end
