class BooksController < ApplicationController
  include Pagy::Backend
  before_action :set_book, only: %i[show edit update destroy]

  # GET /books or /books.json
  def index
    collection = Book.with_attached_cover_image
                     .where(promo_active: true)
                     .includes(:author, :genres, :series, :tags)
                     .left_joins(:series)
                     .order('author.name ASC', 'series.name ASC', 'position ASC')
    @filters = {}

    # for each param with a real value, apply a filter to the books list
    # also add a string to the filters list to display active filters
    filtering_params.each do |p_key, p_val|
      # remove pesky empty string the browser sends over by default with multi-selects
      p_val.reject!(&:blank?)
      collection = if p_key == 'genres'

                     p_val.each do |genre_id|
                       next if genre_id == ''

                       @filters["genre_#{genre_id}"] = Genre.find(genre_id).name
                     end
                     p_val.empty? ? collection : collection.send(:filter_by_genre, p_val)

                   elsif p_key == 'tags'
                     p_val.each do |tag_id|
                       next if tag_id == ''

                       @filters["tag_#{tag_id}"] = Tag.find(tag_id).name
                     end
                     p_val.empty? ? collection : collection.send(:filter_by_tag, p_val)
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
    @series = Series.where(author_id: current_user.id)
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    @series = Series.where(author_id: @book.author_id)
    @show_series = params[:series]
    respond_to do |format|
      if @book.save
        format.html { redirect_to admin_books_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        errors = @book.errors.map { |error| [error.attribute, error.type] }
        log('create', "Creating Book failed with the following errors: #{errors}")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /books/1/edit
  def edit
    @series = Series.where(author_id: @book.author_id)
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    @series = Series.where(author_id: @book.author_id)
    @show_series = params[:series]
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to admin_book_url(@book), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        errors = @book.errors.map { |error| [error.attribute, error.type] }
        log('update', "Updating Book failed with the following errors: #{errors}")
        format.html { render :edit, status: :unprocessable_entity, series: @series }
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
    build_params = params.require(:book).permit(:title, :primary_link, :additional_links, :one_liner_blurb, :description, :display_price, :paperback_price, :free, :promo_active, :spicy, :kindle_unlimited, :queer_rep, :cover_image, :series_id, :author_id, :position, genres: [], tags: [])

    build_params[:genres].reject!(&:empty?).map! { |g_id| Genre.find(g_id) }
    build_params[:tags].reject!(&:empty?).map! { |t_id| Tag.find(t_id) }

    build_params
  end

  def filtering_params
    params.permit(genres: [], tags: [])
  end

  def mass_activation_toggle_params
    params.permit(:authenticity_token, :commit, :_method, :toggle_all, books: [:promo_active])
  end
end
