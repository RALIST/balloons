class CreateCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :calls do |t|
      t.string :username
      t.string :userphone
      t.text :messangers, array: true
      t.timestamps
    end
  end
end
