class BillingController < ApplicationController
  # GET /billing
  def index
    # We suggest that you make this a redirect to the ledger or statement of the currently
    # logged-in party, e.g.
    #redirect_to ledger_url(current_user.company)
  end
  
  # Display a summary of sales, purchases, payments and receipts on accounts.
  # GET /billing/1/ledger  => From the point of view of party 1
  def ledger
    # FIXME check if the current user is allowed to access this ledger
    @self_id = params[:id].to_i
    @summaries = Billing::LedgerItem.account_summaries(@self_id)
    @names = Billing::LedgerItem.sender_recipient_name_map(@self_id, @summaries.keys)
  end
  
  # GET /billing/1    => Show list of transactions where 1 is sender_id or recipient_id
  # GET /billing/1/2  => Show list of transactions between parties 1 and 2
  def statement
    # FIXME check if the current user is allowed to access this account statement
    @self_id = params[:id].to_i
    scope = Billing::LedgerItem.exclude_empty_invoices.sent_or_received_by(@self_id).sorted(:issue_date)
    scope = scope.sent_or_received_by(params[:other_id]) if params[:other_id]
    @in_effect = scope.in_effect.all
    @open_or_pending = scope.open_or_pending.all
    @summary = Billing::LedgerItem.account_summary(@self_id, params[:other_id])
  end
  
  # Display an invoice or credit note.
  # GET /billing/document/1
  # GET /billing/document/1.xml
  def document
    # FIXME check if the current user is allowed to access this ledger item
    @ledger_item = Billing::LedgerItem.find(params[:id])
    
    respond_to do |format|
      format.html { render :text => @ledger_item.render_html, :layout => true }
      format.xml  { render :xml => @ledger_item.render_ubl }
    end
  end
end
