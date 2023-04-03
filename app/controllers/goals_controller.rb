class GoalsController < ApplicationController
  layout "dashboard_layout"
  before_action :set_goal, only: [:show, :destroy, :scoreboard_summary, :update]

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

  def update
    @business = Business.find_by(id: params[:goal][:business_id])
      respond_to do |format|
        if @goal.update(goal_params)
          format.html { redirect_to business_path(@business), notice: "Goal has successfully been updated." }
        else
          format.html { redirect_to business_path(@business), alert: "Goal Could not be updated." }
        end
      end
  end

  def destroy
    @business = @goal.business
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to business_path(@business), notice: "Goal was successfully Deleted" }
    end
  end

  def scoreboard_summary
    @weekly_data_entries = @goal.weekly_data_entries
  end

  private

  def set_goal
    @goal = Goal.find_by(id: params[:id])
  end

  def goal_params
    params[:goal][:channels] = params[:goal][:channels].join(" -#- ")
    params[:goal][:products] = params[:goal][:products].join(" -#- ")

    params.require(:goal).permit(:quater_name, :projected_leads, :budget, :projected_conversion_rate, :projected_revenue, :channels, :products, :business_id, :user_id)
  end
end
