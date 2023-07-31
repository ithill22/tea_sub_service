class AddDefaultStatusToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    change_column_default :subscriptions, :status, 0
  end
end
