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
        format.html { render "goals/form_error_page", alert: "Sorry!! Goal Could not be created.", status: :unprocessable_entity }
      end
    end
  end

  def form_error_page

  end

  def update
    @business = Business.find_by(id: params[:goal][:business_id])
      respond_to do |format|
        if @goal.update(goal_params)
          format.html { redirect_to business_path(@business), notice: "Goal has successfully been updated." }
        else
          format.html { render "goals/form_error_page", alert: "Goal Could not be updated.", status: :unprocessable_entity }
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
    if params[:select_id].present?
      @goal = Goal.find_by(id: params[:select_id])
      @weekly_data_entries = @goal.weekly_data_entries
      @report_type = "goal"
      @selected_option = @goal.unique_code
    elsif params[:report_type] == "yearly"
      @year = params[:date][:year]
      date = Date.new(@year.to_i, 1,1)
      @weekly_data_entries = WeeklyDataEntry.business_yearly_data(params[:business_id], date)
      @report_type = "yearly"
      @selected_option = params[:date][:year]
    else
      @report_type = "goal"
      @weekly_data_entries = @goal.weekly_data_entries
      @selected_option = @goal.unique_code
    end
  end

  private

  def set_goal
    @goal = Goal.find_by(id: params[:id])
  end

  def goal_params
    params[:goal][:channels] = params[:goal][:channels].present? ? params[:goal][:channels].join(" -#- ") : ""
    params[:goal][:products] = params[:goal][:products].present? ? params[:goal][:products].join(" -#- ") : ""

    params.require(:goal).permit(:quater_name, :projected_leads, :budget, :projected_conversion_rate, :projected_revenue, :channels, :products, :business_id, :user_id)
  end
end
