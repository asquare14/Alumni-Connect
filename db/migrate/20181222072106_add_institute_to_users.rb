class AddInstituteToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :institute, :string
  end
end
