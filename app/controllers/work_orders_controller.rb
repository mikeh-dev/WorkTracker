class WorkOrdersController < ApplicationController
  before_action :set_work_order, except: [:index, :new, :create]
  def index
    @upcoming_work_orders = WorkOrder.where(start_date: Date.today..Date.today + 30.days)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @work_order.destroy
    redirect_to work_orders_path, notice: "Work order deleted successfully"
  end

  private

  def set_work_order
    @work_order = WorkOrder.find(params[:id])
  end
end