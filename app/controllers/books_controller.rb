class BooksController < ApplicationController
  get '/books' do
    if logged_in?
      erb :"/books/index"
    else
      flash[:notice] = "You need to log in first to view your reading list."
      redirect to "/login"
    end
  end

  get '/books/new' do
    if logged_in?
      erb :"/books/new"
    else
      flash[:notice] = "You need to log in order to add a book to your reading list."
      redirect to "/login"
    end
  end

  post '/books' do
    if params[:title] != "" && params[:author] != ""
      @book = Book.create(title: params[:title], author: params[:author], user_id: current_user.id)
      flash[:notice] = "Successfully create the book #{@book.title}"
      redirect to "/books"
    else
      flash[:notice] = "Please make sure all fields are filled out."
      redirect to "/books/new"
    end
  end

  get '/books/:id' do
    @book = Book.find_by(id: params[:id])

    if !logged_in?
      flash[:notice] = "You need to log in first to view your book."
      redirect to "/login"
    elsif @book == nil || !current_user.book_ids.include?(@book.id)
      flash[:notice] = "Click on 'View Reading List' to see your books."
      redirect to "/users"
    elsif logged_in? && current_user.book_ids.include?(@book.id)
      erb :"/books/show"
    end
  end

  get '/books/:id/edit' do
    @book = Book.find_by(id: params[:id])

    if !logged_in?
      flash[:notice] = "You need to log in first to view your book."
      redirect to "/login"
    elsif @book == nil || !current_user.book_ids.include?(@book.id)
      flash[:notice] = "Click on 'View Reading List' to see your books."
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
      flash[:notice] = "Successfully made changes to #{@book.title}"
      redirect to "/books/#{@book.id}"
    else
      flash[:notice] = "Please make sure all fields are filled out."
      redirect to "/books/#{@book.id}/edit"
    end
  end

  delete '/books/:id' do
    @book = Book.find_by(id: params[:id])
    @book.delete
    flash[:notice] = "Successfully deleted book."
    redirect "/books"
  end
end
