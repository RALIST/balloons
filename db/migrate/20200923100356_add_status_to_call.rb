class AddStatusToCall < ActiveRecord::Migration[6.0]
  def change
    add_column :calls, :sms_status, :string
    add_column :calls, :sms_sent_at, :timestamp
    add_column :calls, :email_status, :string
    add_column :calls, :email_sent_at, :timestamp
  end
end
