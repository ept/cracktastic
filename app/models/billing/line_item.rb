module Billing
  class LineItem < ActiveRecord::Base
    acts_as_line_item
    
    belongs_to :ledger_item, :class_name => 'Billing::LedgerItem'
  end
end
