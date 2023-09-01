class BookingsController < ApplicationController
  before_action :set_flat, only: :create


  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    authorize @booking
    authorize @flat

    if @booking.save!
      redirect_to flat_path(@flat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:checkin, :checkout, :people, :flat_id)
  end

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end
end
