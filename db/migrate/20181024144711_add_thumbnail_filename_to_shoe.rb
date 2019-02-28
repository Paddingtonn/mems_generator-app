class AddThumbnailFilenameToShoe < ActiveRecord::Migration[5.2]
  def change
    add_column :shoes, :thumbnail_filename, :string
  end
end
