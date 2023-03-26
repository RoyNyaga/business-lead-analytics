class WeeklyDataEntriesController < ApplicationController

  def create
    
  end

  private 

  def weekly_data_entry_params
    params.require(:weekly_data_entry).permit(:goal_id, :business_id, :user_id, :product_id, :contacted_leads, :paid_customers, :budget_expences, :revenue, :conversion_rate, :date)
  end
end
