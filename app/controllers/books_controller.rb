class BooksController < ApplicationController
  get '/books' do
    if logged_in?
      erb :"/books/index"
    else
      redirect to "/login"
    end
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

    if !logged_in?
      redirect to "/login"
    elsif @book == nil || !current_user.book_ids.include?(@book.id)
      redirect to "/users"
    elsif logged_in? && current_user.book_ids.include?(@book.id)
      erb :"/books/show"
    end
  end

  get '/books/:id/edit' do
    @book = Book.find_by(id: params[:id])

    if !logged_in?
      redirect to "/login"
    elsif @book == nil || !current_user.book_ids.include?(@book.id)
      redirect to "/users"
    elsif logged_in? && current_user.book_ids.include?(@book.id)
      erb :"/books/edit"
    end
  end

  patch '/books/:id' do
    @book = Book.find_by(id: params[:id])
    if params[:title] != "" && params[:author] != ""
      @book.title = params[:title]
      @book.author = params[:author]
      @book.save
      redirect to "/books/#{@book.id}"
    else
      redirect to "/books/#{@book.id}/edit"
    end
  end

  delete '/books/:id' do
    @book = Book.find_by(id: params[:id])
    @book.delete
    redirect "/books"
  end
end
