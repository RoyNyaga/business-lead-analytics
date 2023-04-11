ActiveAdmin.register Goal do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :quater_name, :projected_leads, :budget, :projected_conversion_rate, :projected_revenue, :channels, :user_id, :business_id, :products, :actual_leads, :contacted_leads, :conversion_rate, :revenue, :unique_code
  #
  # or
  #
  # permit_params do
  #   permitted = [:quater_name, :projected_leads, :budget, :projected_conversion_rate, :projected_revenue, :channels, :user_id, :business_id, :products, :actual_leads, :contacted_leads, :conversion_rate, :revenue, :unique_code]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
