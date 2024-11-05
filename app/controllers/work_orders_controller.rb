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
  end

  def create
    @work_order = WorkOrder.new(work_order_params)
    @work_order.user = current_user
    if @work_order.save
      redirect_to work_order_path(@work_order), notice: "Work order created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @work_order.update(work_order_params)
      redirect_to work_order_path(@work_order), notice: "Work order updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @work_order.destroy
    redirect_to work_orders_path, notice: "Work order deleted successfully"
  end

  private

  def set_work_order
    @work_order = WorkOrder.find(params[:id])
  end

  def work_order_params
    params.require(:work_order).permit(:customer_name, :customer_phone_number, :start_date, :end_date, :production_job_number, :sales_order_number, :location, :job_type, :status)
  end
end
