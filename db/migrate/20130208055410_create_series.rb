class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :name
      t.integer :rage_id

      t.timestamps
    end
  end
end
