class RepairReport < ApplicationRecord
  has_many_attached :images
  has_many_attached :videos

  validates :customer_name, :customer_email, :location, :sales_order_number, :customer_phone_number, :date, :status, presence: true
end
