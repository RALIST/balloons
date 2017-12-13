class AddPhoneAndUrlToFeedbacks < ActiveRecord::Migration[5.0]
  def change
    change_table :feedbacks do |t|
      t.string :phone
      t.string :social_url
    end
  end
end
