class FlatsController < ApplicationController
  before_action :set_flat, only: [:edit, :update, :destroy, :show]

  def index
    @flats = policy_scope(Flat)
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: flat}),
        marker_html: render_to_string(partial: "markers")
      }
    end

    if params[:query].present?
      sql_subquery = "name ILIKE :query OR address ILIKE :query OR description ILIKE :query"
      @flats = @flats.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    authorize @flat

    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize @flat
    @booking = Booking.new
    authorize @booking
    @flat_array = Flat.where(id: @flat.id)
    @marker = @flat_array.geocoded.map do |flat| {
      lat: flat.latitude,
      lng: flat.longitude,
      marker_html: render_to_string(partial: "markers")
    }
    end
  end

  def edit
    authorize @flat
  end

  def update
    authorize @flat
    @flat.user = current_user
    if @flat.update(flat_params)
      redirect_to flat_path(@flat), notice: 'Upadated successfully!', status: :see_other
    else
      render :edit
    end
  end

  def destroy
    authorize @flat
    @flat.destroy
    redirect_to flats_path, notice: 'Flat was successfully destroyed!', status: :see_other
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :description, :price, :address, :photo)
  end

  def set_flat
    @flat = Flat.find(params[:id])
  end
end
