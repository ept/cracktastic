module Billing
  class MonthlySubscriptionCharge < LineItem
    
    before_validation :calculate_tax
    
    def initialize(*args)
      super
      self.tax_point ||= Time.now.utc
    end
    
    def calculate_tax
      self.tax_amount = 0.15*net_amount
    end
  end
end
