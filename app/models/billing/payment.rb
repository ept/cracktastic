module Billing
  class Payment < LedgerItem
    acts_as_payment
  end
end
