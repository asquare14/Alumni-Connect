class CreateMentorMentees < ActiveRecord::Migration[5.1]
  def change
    create_table :mentor_mentees do |t|
      t.integer :mentor_id
      t.integer :mentee_id
      t.timestamps
    end
  end
end
