class UsersController < ApplicationController
  get '/users' do
    if logged_in?
      erb :"/users/index"
    else
      redirect to "/login"
    end
  end
end
