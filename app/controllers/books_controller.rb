class BooksController < ApplicationController
before_action :is_matching_login_user
before_action :is_matching_login_book,only: [:edit]

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book), notice: "You have create book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end


  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

   def is_matching_login_user
     unless user_signed_in?
     redirect_to new_user_session_path
     end
   end


  def is_matching_login_book
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end


end
