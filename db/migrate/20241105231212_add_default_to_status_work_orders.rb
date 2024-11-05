class AddDefaultToStatusWorkOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_default :work_orders, :status, "Booked"
  end
end
