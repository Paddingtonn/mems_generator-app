class AddColorToShoes < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :size, :integer
  end
end
