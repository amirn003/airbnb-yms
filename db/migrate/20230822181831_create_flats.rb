class CreateFlats < ActiveRecord::Migration[7.0]
  def change
    create_table :flats do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.text :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
