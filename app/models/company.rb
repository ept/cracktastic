class Company < ActiveRecord::Base
  has_many :users
  has_many :purchases
  has_many :jokes, :through => :purchases

  attr_accessible :name, :contact_name, :address, :city, :state, :postal_code, :country, :country_code, :tax_number
  validates_presence_of :name, :contact_name, :address, :city, :state, :postal_code, :country, :country_code
end
