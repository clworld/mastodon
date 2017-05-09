class OptimizeIndexSubscriptions < ActiveRecord::Migration[5.0]
  def up
    add_index :subscriptions, [:account_id, :callback_url, :deleted_at], unique: true, name: 'index_subscriptions_on_account_and_callback'
    remove_index :subscriptions, columns: [:callback_url, :account_id, :deleted_at], name: 'index_subscriptions_on_callback_and_account'
  end

  def down
    add_index :subscriptions, [:callback_url, :account_id, :deleted_at], unique: true, name: 'index_subscriptions_on_callback_and_account'
    remove_index :subscriptions, columns: [:account_id, :callback_url, :deleted_at], name: 'index_subscriptions_on_account_and_callback'
  end
end
