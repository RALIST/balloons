class AddPromocodeToFeedbacks < ActiveRecord::Migration[5.0]
  def change
    change_table :feedbacks do |t|
      t.string :promocode
    end
  end
end
