class BusinessesController < ApplicationController
  before_action :set_business, only: %i[show edit update destroy]

  # GET /businesses or /businesses.json
  def index
    @businesses = Business.with_attached_logo_image.all
  end

  # GET /businesses/1 or /businesses/1.json
  def show; end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit; end

  # POST /businesses or /businesses.json
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        @business.process_logo_variants
        format.html { redirect_to business_url(@business), notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1 or /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        @business.process_logo_variants
        format.html { redirect_to business_url(@business), notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1 or /businesses/1.json
  def destroy
    @business.destroy

    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_business
    @business = Business.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def business_params
    params.require(:business).permit(:name, :website_url)
  end
end
