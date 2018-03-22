ActiveAdmin.register User do
  permit_params :username, :email, :password, :position_in_the_company, :type_of_user
end
