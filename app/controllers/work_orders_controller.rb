class WorkOrdersController < ApplicationController
  before_action :set_work_order, except: [:index, :new, :create]
  def index
    @upcoming_work_orders = WorkOrder.where(start_date: Date.today..Date.today + 30.days, status: "Booked")
    @completed_work_orders = WorkOrder.where(status: "Completed")
    @all_work_orders = @upcoming_work_orders + @completed_work_orders
  end

  def show
  end

  def new
    @work_order = WorkOrder.new
  end

  def create
    @work_order = WorkOrder.new(work_order_params)
    @work_order.user = current_user
    if @work_order.save
      if params[:commit] == "Save"
        redirect_to edit_work_order_path(@work_order), notice: "Work order created successfully"
      else
        redirect_to work_orders_path, notice: "Work order created successfully"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @work_order.update(work_order_params)
      if params[:save_and_back]
        redirect_to work_orders_path
      else
        redirect_to edit_work_order_path(@work_order)
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @work_order.destroy
    redirect_to work_orders_path, notice: "Work order deleted successfully"
  end

  def remove_image
    @attachment = @work_order.vehicle_images.find(params[:image_id])
    @attachment.purge
    
    respond_to do |format|
      format.html { redirect_to edit_work_order_path(@work_order), notice: 'Image was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_work_order
    @work_order = WorkOrder.find(params[:id])
  end

  def work_order_params
    params.require(:work_order).permit(:vehicle_registration_number, :vehicle_make, :vehicle_model, :vehicle_mileage, :vehicle_damage_notes, :customer_name, :customer_phone_number, :customer_email, :production_job_number, :sales_order_number, :job_type, :job_instructions, :status, :assigned_to, :location, :start_date, :end_date, :job_notes, :extra_parts_used, vehicle_images: [])
  end
end
