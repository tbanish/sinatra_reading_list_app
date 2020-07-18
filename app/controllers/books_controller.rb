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

  get '/books/:id' do
    @book = Book.find_by(id: params[:id])
    if logged_in? && current_user.book_ids.include?(@book.id)
      erb :"/books/show"
    elsif !logged_in?
      redirect to "/login"
    else
      redirect to "/users"
    end
  end

  get '/books/:id/edit' do
    @book = Book.find_by(id: params[:id])
    if logged_in? && current_user.book_ids.include?(@book.id)
      erb :"/books/edit"
    elsif !logged_in?
      redirect to "/login"
    else
      redirect to "/users"
    end
  end

end
