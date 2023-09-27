class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue
    InvoiceItem.select("invoice_items.id, invoice_items.quantity * invoice_items.unit_price * (1 - (MAX(discounts.percentage) / 100.0)) as total_discounted_revenue")
      .joins(item: {merchant: :discounts})
      .where('invoice_items.quantity >= discounts.threshold')
      .group('invoice_items.id')
      .sum(&:total_discounted_revenue)
  end
end
