class WorkOrder < ApplicationRecord
  belongs_to :user

  enum job_type: {
    repair: 0,
    installation: 1,
    floor_protection_and_installation: 2
  }

  validates :vehicle_registration_number, length: { maximum: 8 }
  validates :production_job_number, :sales_order_number, :location, :start_date, :end_date, presence: true
end