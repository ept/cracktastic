module Billing
  class CreditNote < LedgerItem
    acts_as_credit_note
  end
end
