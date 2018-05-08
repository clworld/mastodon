# frozen_string_literal: true

class Scheduler::SubscriptionsScheduler
  include Sidekiq::Worker

  def perform
    Pubsubhubbub::SubscribeWorker.push_bulk(expiring_accounts.pluck(:id))
  end

  private

  def expiring_accounts
    Account.expiring(2.day.from_now).partitioned
  end
end
