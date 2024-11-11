class CreateRepairReports < ActiveRecord::Migration[7.1]
  def change
    create_table :repair_reports do |t|
      t.string :customer_name
      t.string :customer_email
      t.string :location
      t.string :sales_order_number
      t.string :customer_phone_number
      t.date :date
      t.string :status
      t.text :notes
      t.string :vehicle_registration_number

      t.timestamps
    end
  end
end