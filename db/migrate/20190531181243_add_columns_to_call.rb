class AddColumnsToCall < ActiveRecord::Migration[5.0]
  def change
    change_table :calls do |t|
      t.string :event
      t.string :person
      t.string :budget
      t.string :desc
    end
  end
end
