# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def author_show
    @author = User.find(params[:id])
  end
end
