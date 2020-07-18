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

  post '/books' do
    if params[:title] != "" && params[:author] != ""
      @book = Book.create(title: params[:title], author: params[:author], user_id: current_user.id)
      redirect to "/books"
    else
      redirect to "/books/new"
    end
  end

end
