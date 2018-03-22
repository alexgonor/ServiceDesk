ActiveAdmin.register Ticket do
  permit_params :title, :detailed_description, :deadline, :type_of_ticket, :responsible_unit, :user_id
end
