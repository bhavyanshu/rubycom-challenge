class CreateBaskets < ActiveRecord::Migration[5.1]
  def up
    create_table :baskets do |t|
      t.integer :capacity, :null => false
      t.string :fill_rate, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :baskets
  end
end
