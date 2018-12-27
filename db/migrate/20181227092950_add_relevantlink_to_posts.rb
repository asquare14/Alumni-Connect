class AddRelevantlinkToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :rel_link, :string
  end
end
