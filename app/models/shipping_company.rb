# frozen_string_literal: true

class ShippingCompany < ApplicationRecord
  validates :name, :corporate_name, :email_domain, :cnpj, :billing_adress, presence: true
  validates :cnpj, format: { with: %r{\A\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}\z} }
  validates :email_domain, format: { with: /\A([\w-]+\.)+[\w-]+\z/ }
  validates :cnpj, uniqueness: true
  has_many :users, dependent: :destroy
  has_one :price_table, dependent: :destroy
  has_one :delivery_time_table, dependent: :destroy

  before_create :set_status
  after_create :set_price_table, :set_delivery_time_table

  private

  def set_price_table
    PriceTable.create(shipping_company: self, minimum_value: 0)
  end

  def set_delivery_time_table
    DeliveryTimeTable.create(shipping_company: self)
  end

  def set_status
    self.active = true
  end
end
