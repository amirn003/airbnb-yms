class RemoveDateFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :date, :string
  end
end
