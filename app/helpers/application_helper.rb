module ApplicationHelper
  def action_text(object)
    object.persisted? ? "Update" : "Create"
  end

  def scoreboard_title(report_type, year: nil, goal: nil)
    if report_type == "goal"
      "Scoreboard Summary - #{goal.unique_code}"
    else
      "Scoreboard Summary for the year #{year}"
    end
  end
end
