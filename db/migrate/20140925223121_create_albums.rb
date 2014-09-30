class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :user, index: true
      t.string :title

      t.timestamps
    end
  end
end
