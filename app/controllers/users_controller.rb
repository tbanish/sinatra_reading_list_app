class UsersController < ApplicationController
  get '/users' do
    erb :index
  end
end
