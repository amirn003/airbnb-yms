class AddCheckoutToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :checkout, :date
  end
end
