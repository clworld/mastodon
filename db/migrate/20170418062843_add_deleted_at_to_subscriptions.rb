class AddDeletedAtToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :deleted_at, :datetime
    add_index :subscriptions, [:callback_url, :account_id, :deleted_at], unique: true, name: 'index_subscriptions_on_callback_and_account'
    remove_index :subscriptions, [:callback_url, :account_id]
  end
end
