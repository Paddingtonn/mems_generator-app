class AddTitleToShoe < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :title, :string
  end
end
