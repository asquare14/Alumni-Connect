class RemoveExpertiseFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :expertise, :string
  end
end
