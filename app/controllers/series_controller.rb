class SeriesController < ApplicationController
  def new
    @series = Series.new
  end

  def create
    @series = Series.new(series_params)
    @author_series = Series.where(author_id: current_user.id)

    if @series.save
      respond_to do |format|
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
