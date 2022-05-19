class ShippingCompany < ApplicationRecord
  validates :name, :corporate_name, :email_domain, :cnpj, :billing_adress, :active, presence: true
end