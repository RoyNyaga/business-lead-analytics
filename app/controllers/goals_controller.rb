class GoalsController < ApplicationController
  before_action :set_goal, only: [:show]

  def show
    @weekly_data_entry = WeeklyDataEntry.new
  end

  def create
    @goal = Goal.new(goal_params)
    @business = Business.find_by(id: params[:goal][:business_id])
    respond_to do |format|
      if @goal.save
        format.html { redirect_to business_path(@business), notice: "Goal was successfully Created" }
      else
        format.html { redirect_to business_path(@business), status: :unprocessable_entity }
      end
    end
  end

  private

  def set_goal
    @goal = Goal.find_by(id: params[:id])
  end

  def goal_params
    params[:goal][:channels] = params[:goal][:channels].join(" -#- ")
    params.require(:goal).permit(:quater_name, :projected_leads, :budget, :projected_conversion_rate, :projected_revenue, :channels, :business_id, :user_id)
  end
end
