class BooksController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render "/books/edit"
    end
  end
  
  def create
    @user = current_user
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = 'You have created book successfully.'
     redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      render "index"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end