ActiveAdmin.register Championship do
  index do
    column :id
    column :season
    column :name
    column :calendar
    column :created_at
    column :updated_at
    actions
  end
end