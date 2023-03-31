class WeeklyDataEntriesController < ApplicationController

  def create
    @goal = Goal.find_by(id: params[:weekly_data_entry][:goal_id])
    @weekly_data_entry = WeeklyDataEntry.new(weekly_data_entry_params)
    @weekly_data_entry.parse_leads(params)
    respond_to do |format|
      if @weekly_data_entry.save
        format.html { redirect_to @goal, notice: "Data Entry was successfully Added" }
      else
        format.html { redirect_to @goal, alert: "Data Entry could not be created", status: :unprocessable_entity }
      end
    end
  end

  def update
    @goal = Goal.find_by(id: params[:weekly_data_entry][:goal_id])
    @weekly_data_entry = WeeklyDataEntry.find_by(id: params[:id])
    @weekly_data_entry.parse_leads(params)
    respond_to do |format|
      if @weekly_data_entry.update(weekly_data_entry_params)
        format.html { redirect_to @goal, notice: "Data Entry was successfully Updated" }
      else
        format.html { redirect_to @goal, alert: "Data Entry could not be Updated", status: :unprocessable_entity }
      end
    end
  end

  private 

  def weekly_data_entry_params
    params.require(:weekly_data_entry).permit(:goal_id, :business_id, :user_id, :contacted_leads, :paid_customers, :budget_expences, :revenue, :conversion_rate, :date)
  end
end
