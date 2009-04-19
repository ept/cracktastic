module Billing
  class SubscriptionInvoice < Invoice
    def initialize(*args)
      super
      self.status ||= 'open'
      self.period_start ||= Time.now.utc.at_beginning_of_month
      self.period_end ||= period_start.next_month.at_beginning_of_month
      self.issue_date ||= period_end
      self.due_date ||= period_end + 14.days
      self.description ||= "Cracktastic subscription for #{Time.now.strftime('%B %Y')}"
    end
  end
end
