class Joke < ActiveRecord::Base
  has_many :purchases
  
  named_scope :not_purchased_by_company, lambda{|company| {
    :joins => 'LEFT JOIN purchases ON purchases.joke_id = jokes.id AND ' +
      sanitize_sql_array(['purchases.company_id = ?', company.id]),
    :conditions => 'purchases.id IS NULL'
  }}

  validates_presence_of :question, :answer
end
