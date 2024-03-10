class SeriesController < ApplicationController
  def new; end

  def create
    @new_series = Series.new(series_params)
    if @new_series.save
      respond_to do |format|
        @series = Series.where(author_id: current_user.id)
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def series_params
    params.require(:series).permit(:name, :author_id)
  end
end
