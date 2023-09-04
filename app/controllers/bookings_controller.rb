class BookingsController < ApplicationController
  before_action :set_flat, only: [:create, :destroy]


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
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to root_path, notice: 'Booking was successfully destroyed!', status: :see_other
  end

  def update_status
    @booking = Booking.find(params[:id])
    authorize @booking
    if @booking.flat.user == current_user
      if @booking.booking_status == true
        @booking.update(booking_status: false)
      else
        @booking.update(booking_status: true)
      end
      redirect_to bookings_path, notice: 'Booking status updated successfully.'
    else
      redirect_to bookings_path, alert: 'You are not authorized to update this booking.'
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
