class RemovePaperclipColumnsFromModels < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :avatar_file_name, :string
    remove_column :users, :avatar_content_type, :string
    remove_column :users, :avatar_file_size, :bigint
    remove_column :users, :avatar_updated_at, :datetime

    remove_column :pictures, :asset_file_name, :string
    remove_column :pictures, :asset_content_type, :string
    remove_column :pictures, :asset_file_size, :bigint
    remove_column :pictures, :asset_updated_at, :datetime

    remove_column :documents, :attachment_file_name, :string
    remove_column :documents, :attachment_content_type, :string
    remove_column :documents, :attachment_file_size, :bigint
    remove_column :documents, :attachment_updated_at, :datetime
  end
end
