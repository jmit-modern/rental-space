class CreateSpaceImages < ActiveRecord::Migration[6.1]
  def up
    create_table :space_images do |t|
      t.belongs_to :space, index: true
      t.integer :image_type, comment: "Image type (0: image, 1: movie)"
      t.string :url, comment: "Image url"
      t.string :file_name, comment: "File name"
      t.string :caption, comment: "Image caption"

      t.timestamps
    end
  end

  def down
    drop_table :space_images
  end
end
