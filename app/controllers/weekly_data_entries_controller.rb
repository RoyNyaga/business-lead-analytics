class WeeklyDataEntriesController < ApplicationController

  def create
    @weekly_data_entry = WeeklyDataEntry.new(weekly_data_entry_params)
    @weekly_data_entry.parse_leads(params)
    respond_to do |format|
      @goal = @weekly_data_entry.goal
      if @weekly_data_entry.save
        format.html { redirect_to @goal, notice: "Data Entry was successfully Added" }
      else
        format.html { redirect_to @goal, alert: "Data Entry could not be created", status: :unprocessable_entity }
      end
    end
  
  end

  private 

  def weekly_data_entry_params
    params.require(:weekly_data_entry).permit(:goal_id, :business_id, :user_id, :contacted_leads, :paid_customers, :budget_expences, :revenue, :conversion_rate, :date)
  end
end
