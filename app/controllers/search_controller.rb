# frozen_string_literal: true

class SearchController < ApplicationController
  include Pagy::Backend
  def index
    return if params[:query].blank?

    user_query = User.ransack(name_i_cont: params[:query])
    book_query = Book.ransack(title_i_cont: params[:query])

    @pagy_authors, @authors = pagy(user_query.result, items: 6, link_extra: 'data-turbo-frame="authors_frame"')
    @pagy_books, @books = pagy(book_query.result, items: 8, link_extra: 'data-turbo-frame="books_frame"')
  end
end
