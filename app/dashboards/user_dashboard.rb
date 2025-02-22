require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    invited_by: Field::Polymorphic,
    club_admin_roles: Field::HasMany,
    participations: Field::HasMany,
    sections: Field::HasMany,
    training_presences: Field::HasMany,
    duty_tasks: Field::HasMany,
    match_availabilities: Field::HasMany,
    groups: Field::HasMany,
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    first_name: Field::String,
    last_name: Field::String,
    nickname: Field::String,
    phone_number: Field::String,
    authentication_token: Field::String,
    invitation_token: Field::String,
    invitation_created_at: Field::DateTime,
    invitation_sent_at: Field::DateTime,
    invitation_accepted_at: Field::DateTime,
    invitation_limit: Field::Number,
    invitations_count: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  first_name
  last_name
  nickname
  email
  phone_number
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  invited_by
  club_admin_roles
  participations
  sections
  training_presences
  duty_tasks
  match_availabilities
  groups
  id
  email
  encrypted_password
  reset_password_token
  reset_password_sent_at
  remember_created_at
  sign_in_count
  current_sign_in_at
  last_sign_in_at
  current_sign_in_ip
  last_sign_in_ip
  created_at
  updated_at
  first_name
  last_name
  nickname
  phone_number
  authentication_token
  invitation_token
  invitation_created_at
  invitation_sent_at
  invitation_accepted_at
  invitation_limit
  invitations_count
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  invited_by
  club_admin_roles
  participations
  sections
  training_presences
  duty_tasks
  match_availabilities
  groups
  email
  encrypted_password
  reset_password_token
  reset_password_sent_at
  remember_created_at
  sign_in_count
  current_sign_in_at
  last_sign_in_at
  current_sign_in_ip
  last_sign_in_ip
  first_name
  last_name
  nickname
  phone_number
  authentication_token
  invitation_token
  invitation_created_at
  invitation_sent_at
  invitation_accepted_at
  invitation_limit
  invitations_count
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    "<#{user.email}>"
  end
end
