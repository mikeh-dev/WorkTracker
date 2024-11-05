class CreateWorkOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :work_orders do |t|
      t.string :vehicle_registration_number
      t.string :vehicle_make
      t.string :vehicle_model
      t.string :vehicle_mileage
      t.text :vehicle_damage_notes

      t.string :customer_name
      t.string :customer_phone_number
      t.string :customer_email
      t.string :production_job_number
      t.string :sales_order_number
      
      t.integer :job_type
      t.text :job_instructions
      t.string :status
      t.string :assigned_to
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.text :job_notes
      t.text :extra_parts_used

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end