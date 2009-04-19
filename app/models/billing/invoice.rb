module Billing
  class Invoice < LedgerItem
    acts_as_invoice
  end
end
