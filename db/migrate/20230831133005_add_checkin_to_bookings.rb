class AddCheckinToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :checkin, :date
  end
end
