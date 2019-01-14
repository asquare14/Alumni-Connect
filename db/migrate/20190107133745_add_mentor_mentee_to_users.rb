class AddMentorMenteeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mentor, :bool
    add_column :users, :mentee, :bool
  end
end
