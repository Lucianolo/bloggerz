class AddPreviewLinkToBooks < ActiveRecord::Migration
  def change
    add_column :books, :preview_link, :string
  end
end
