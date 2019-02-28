class CreateShoesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :shoes do |t|
      t.string :filename
      t.string :original_filename

      t.timestamps
    end
  end
end
