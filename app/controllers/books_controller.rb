class BooksController < ApplicationController

  get '/books' do
    erb :"/books/index"
  end

  get '/books/new' do
    if logged_in?
      erb :"/books/new"
    else
      redirect to "/login"
    end
  end

end
