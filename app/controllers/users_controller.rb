# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def author_show
    @author = User.find(params[:id])
    @books = Book.promo_active_per_author(@author.id)
                 .left_joins(:series)
                 .order('series.name Asc', 'position ASC')
  end

  def author_spotlight
    @authors = User.valid_users.in_the_spotlight
  end
end
