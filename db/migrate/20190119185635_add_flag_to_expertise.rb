class AddFlagToExpertise < ActiveRecord::Migration[5.1]
  def change
    add_column :expertises, :flag, :integer, default: 0
  end
end
