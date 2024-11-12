class RepairReportsController < ApplicationController
  before_action :set_repair_report, except: [:index, :new, :create]

  def index
    @upcoming_repair_reports = RepairReport.where(status: "Booked")
    @completed_repair_reports = RepairReport.where(status: "Completed")
    @all_repair_reports = @upcoming_repair_reports + @completed_repair_reports
  end

  def new
    @repair_report = RepairReport.new
  end

  def create
    @repair_report = RepairReport.new(repair_report_params)
    if @repair_report.save
      redirect_to repair_reports_path, notice: "Repair report created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @repair_report.update(repair_report_params)
      redirect_to repair_reports_path, notice: "Repair report updated successfully"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @repair_report.destroy
    redirect_to repair_reports_path, notice: "Repair report deleted successfully"
  end

  private

  def repair_report_params
    params.require(:repair_report).permit(:customer_name, :customer_email, :location, :sales_order_number, :customer_phone_number, :date, :status, :notes, :vehicle_registration_number)
  end

  def set_repair_report
    @repair_report = RepairReport.find(params[:id])
  end
end