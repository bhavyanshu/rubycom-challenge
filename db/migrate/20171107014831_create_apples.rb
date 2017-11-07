class CreateApples < ActiveRecord::Migration[5.1]
  def change
    create_table :apples do |t|
      t.references :basket, :foreign_key => true
      t.string :variety, :null => false
      t.timestamps
    end
  end
end
