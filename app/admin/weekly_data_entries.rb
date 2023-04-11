ActiveAdmin.register WeeklyDataEntry do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :goal_id, :business_id, :user_id, :leads_per_week, :contacted_leads, :paid_customers, :budget_expences, :revenue, :conversion_rate, :channel_leads_per_week, :date, :product_leads_per_week
  #
  # or
  #
  # permit_params do
  #   permitted = [:goal_id, :business_id, :user_id, :leads_per_week, :contacted_leads, :paid_customers, :budget_expences, :revenue, :conversion_rate, :channel_leads_per_week, :date, :product_leads_per_week]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
