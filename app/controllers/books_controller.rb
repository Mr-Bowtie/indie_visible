class BooksController < ApplicationController
  include Pagy::Backend
  before_action :set_book, only: %i[show edit update destroy]

  # GET /books or /books.json
  def index
    collection = Book.with_attached_cover_image.where(promo_active: true).includes(:author, :genres).order(:author_id)
    @filters = {}

    # for each param with a real value, apply a filter to the books list
    # also add a string to the filters list to display active filters
    filtering_params.select { |_, val| val != '0' && val != '' }.each do |p_key, p_val|
      collection = if p_key == 'genre'
                     @filters[p_key] = Genre.find(p_val).name
                     collection.send :filter_by_genre, p_val
                   else
                     @filters[p_key] = p_val
                     collection.send p_key.to_sym
                   end
    end

    @pagy, @books = pagy(collection)
    @live_promo = Promo.active.first
    @upcoming_promo = Promo.next_up.first
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
    @pagy, @books = pagy(Book.with_attached_cover_image.includes(:author, :genres).all.order(:author_id, :title), items: 50)
    render 'bulk_activation_toggle_form'
  end

  def bulk_activation_toggle
    if mass_activation_toggle_params[:toggle_all] == 'true'
      Book.transaction do
        Book.update_all(promo_active: true)
      end
      redirect_to admin_books_path, notice: 'Books promo status successfully updated'
    elsif mass_activation_toggle_params[:toggle_all] == 'false'
      Book.transaction do
        Book.update_all(promo_active: false)
      end
      redirect_to admin_books_path, notice: 'Books promo status successfully updated'
    else
      Book.transaction do
        mass_activation_toggle_params[:books].each do |id, toggle_params|
          book = Book.find(id)
          book.update!(toggle_params)
        end
      end
      redirect_to books_bulk_activation_toggle_form_path, notice: 'Books promo status successfully updated'
    end
  rescue StandardError => e
    redirect_to admin_books_path, alert: "Error setting books promo status: #{e}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :primary_link, :additional_links, :one_liner_blurb, :description, :display_price, :paperback_price, :free, :promo_active, :genre_id, :spicy, :kindle_unlimited, :queer_rep, :cover_image)
  end

  def filtering_params
    params.permit(:genre, :spicy, :not_spicy, :kindle_unlimited, :queer_rep, :free)
  end

  def mass_activation_toggle_params
    params.permit(:authenticity_token, :commit, :_method, :toggle_all, books: [:promo_active])
  end
end
