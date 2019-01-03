class AddSchoolStudentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :school_student, :string
  end
end
