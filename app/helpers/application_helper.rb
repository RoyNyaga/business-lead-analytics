module ApplicationHelper
  def action_text(object)
    object.persisted? ? "Update" : "Create"
  end
end
