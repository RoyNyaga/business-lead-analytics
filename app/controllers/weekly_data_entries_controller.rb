class WeeklyDataEntriesController < ApplicationController
  before_action :set_weekly_data_entry, only: [:form_error_page, :update, :destroy]

  def create
    @goal = Goal.find_by(id: params[:weekly_data_entry][:goal_id])
    @weekly_data_entry = WeeklyDataEntry.new(weekly_data_entry_params)
    @weekly_data_entry.parse_leads(params)
    respond_to do |format|
      if @weekly_data_entry.save
        format.html { redirect_to @goal, notice: "Data Entry was successfully Added" }
      else
        format.html { render "form_error_page", alert: "Data Entry could not be created", status: :unprocessable_entity }
      end
    end
  end

  def update
    @goal = Goal.find_by(id: params[:weekly_data_entry][:goal_id])
    @weekly_data_entry.parse_leads(params)
    respond_to do |format|
      if @weekly_data_entry.update(weekly_data_entry_params)
        format.html { redirect_to @goal, notice: "Data Entry was successfully Updated" }
      else
        format.html { render "form_error_page", alert: "Data Entry could not be Updated", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @goal = @weekly_data_entry.goal
    @weekly_data_entry.destroy
    flash[:alert] = "Data Entry was successfully deleted"
    redirect_to @goal
  end

  def form_error_page
  end

  private 

  def set_weekly_data_entry
    @weekly_data_entry = WeeklyDataEntry.find_by(id: params[:id])
  end

  def weekly_data_entry_params
    params.require(:weekly_data_entry).permit(:goal_id, :business_id, :user_id, :contacted_leads, :paid_customers, :budget_expences, :revenue, :conversion_rate, :date)
  end
end
