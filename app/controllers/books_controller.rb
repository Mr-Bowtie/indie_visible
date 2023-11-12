class BooksController < ApplicationController
  include Pagy::Backend
  before_action :set_book, only: %i[show edit update destroy]

  # GET /books or /books.json
  def index
    collection = Book.all
    @filters = []

    # for each param with a real value, apply a filter to the books list
    # also add a string to the filters list to display active filters
    filtering_params.select { |_, val| val != '0' && val != '' }.each do |p_key, p_val|
      collection = if p_key == 'genre'
                     @filters.push(Genre.find(p_val).name)
                     collection.send :filter_by_genre, p_val
                   else
                     # TODO: add a decorator here that transforms the attribute name to user friendly string. Not dire, just looks ugly right now.
                     @filters.push(p_key)
                     collection.send p_key.to_sym
                   end
    end

    @pagy, @books = pagy(collection)
  end

  # GET /books/1 or /books/1.json
  def show; end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit; end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def bulk_activation_toggle_form
    @pagy, @books = pagy(Book.all)
    render 'bulk_activation_toggle_form'
  end

  def bulk_activation_toggle
    Book.transaction do
      mass_activation_toggle_params[:books].each do |toggle_params|
        book = Book.find(toggle_params[:id])
        book.update!(toggle_params.except(:id))
      end
    end

    redirect_to admin_root_path, notice: 'Books promo status successfully updated'
  rescue StandardError => e
    redirect_to admin_root_path, alert: "Error setting books promo status: #{e}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :primary_link, :additional_links, :one_liner_blurb, :description, :display_price, :free, :promo_active, :tag_id, :spicy, :kindle_unlimited, :queer_rep, :cover_image)
  end

  def filtering_params
    params.permit(:tag, :spicy, :kindle_unlimited, :queer_rep)
  end

  def mass_activation_toggle_params
    params.permit(:authenticity_token, :commit, :_method, books: [:promo_active])
  end
end
