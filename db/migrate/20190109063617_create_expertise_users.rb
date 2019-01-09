class CreateExpertiseUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :expertise_users do |t|
      t.references :user, foreign_key: true
      t.references :expertise, foreign_key: true

      t.timestamps
    end
  end
end
