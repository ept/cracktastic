class Purchase < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :joke
  
  validates_presence_of :company_id, :user_id, :joke_id
end
