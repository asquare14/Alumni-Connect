class AddExpertiseToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :expertise, :string
  end
end
