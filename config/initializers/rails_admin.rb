# RailsAdmin config file. Generated on November 11, 2011 14:30
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|
  
  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Ask AMEE', 'Admin']

  #  ==> Authentication (before_filter)
  config.authenticate_with do
    user = Rails.env.production? ? ENV['ADMIN_USER'] : 'admin'
    pass = Rails.env.production? ? ENV['ADMIN_PASSWORD'] : 'password'
    authenticate_or_request_with_http_basic('AskAMEE Admin') do |username, password|
      username == user  && password == pass
    end
  end

end
# RailsAdmin config file. Generated on November 11, 2011 14:51
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.current_user_method { current_user } # auto-generated
  
  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['AMEE PersonalScore', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  #  ==> Authentication (before_filter)
  # This is run inside the controller instance so you can setup any authentication you need to.
  # By default, the authentication will run via warden if available.
  # and will run on the default user scope.
  # If you use devise, this will authenticate the same as authenticate_user!
  # Example Devise admin
  # RailsAdmin.config do |config|
  #   config.authenticate_with do
  #     authenticate_admin!
  #   end
  # end

  config.authenticate_with do
    user = Rails.env.production? ? ENV['ADMIN_USER'] : 'admin'
    pass = Rails.env.production? ? ENV['ADMIN_PASSWORD'] : 'password'
    authenticate_or_request_with_http_basic('AskAMEE Admin') do |username, password|
      username == user  && password == pass
    end
  end

  # Example Custom Warden
  # RailsAdmin.config do |config|
  #   config.authenticate_with do
  #     warden.authenticate! :scope => :paranoid
  #   end
  # end

  #  ==> Authorization
  # Use cancan https://github.com/ryanb/cancan for authorization:
  # config.authorize_with :cancan

  # Or use simple custom authorization rule:
  # config.authorize_with do
  #   redirect_to root_path unless warden.user.is_admin?
  # end

  # Use a specific role for ActiveModel's :attr_acessible :attr_protected
  # Default is :default
  # config.attr_accessible_role { :default }
  # _current_user is accessible in the block if you need to make it user specific:
  # config.attr_accessible_role { _current_user.role.to_sym }

  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Checkin, Leg, User]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Checkin, Leg, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields :name, :other_name do
  #       # Configuration here will affect all fields named [:name, :other_name], in the list section, for all included models
  #     end
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field!
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Here goes your cross-section field configuration for ModelName.
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  #   show do
  #     # Here goes the fields configuration for the show view
  #   end
  #   export do
  #     # Here goes the fields configuration for the export view (CSV, yaml, XML)
  #   end
  #   edit do
  #     # Here goes the fields configuration for the edit view (for create and update view)
  #   end
  #   create do
  #     # Here goes the fields configuration for the create view, overriding edit section settings
  #   end
  #   update do
  #     # Here goes the fields configuration for the update view, overriding edit section settings
  #   end
  # end
  
  # Your model's configuration, to help you get started:
  
  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible.
  # There can be different reasons for that:
  #  - belongs_to _id and _type (polymorphic) columns are hidden in favor of their associations
  #  - associations are hidden if they have no matchable model found (model not included or non-existant)
  #  - they are part of a bigger plan in a plugin (Devise/Paperclip) and hidden by contract
  # Some fields may be hidden depending on the section, if they aren't deemed suitable for display or edition on that section
  #  - non-editable columns (:id, :created_at, ..) in edit sections
  #  - has_many/has_one associations in list section (hidden by default for performance reasons)
  # Fields may also be marked as read_only (and thus not editable) if they are not mass-assignable by current_user
  

  # config.model Checkin do
  #   # Found associations:
  #     field :outgoing_leg, :has_one_association 
  #     field :incoming_leg, :has_one_association 
  #     field :user, :belongs_to_association 
  #   # Found columns:
  #     field :id, :integer 
  #     field :lat, :string 
  #     field :lon, :string 
  #     field :timestamp, :datetime 
  #     field :foursquare_id, :string 
  #     field :timezone, :string 
  #     field :created_at, :datetime 
  #     field :updated_at, :datetime 
  #     field :venue_name, :string 
  #     field :user_id, :integer         # Hidden 
  #     field :icon, :string 
  #     field :leg_id, :integer 
  #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end

  # config.model Leg do
  #   # Found associations:
  #     field :start_checkin, :belongs_to_association 
  #     field :end_checkin, :belongs_to_association 
  #     field :user, :belongs_to_association 
  #   # Found columns:
  #     field :id, :integer 
  #     field :distance, :string 
  #     field :co2, :string 
  #     field :name, :string 
  #     field :end_checkin_id, :integer         # Hidden 
  #     field :created_at, :datetime 
  #     field :updated_at, :datetime 
  #     field :user_id, :integer         # Hidden 
  #     field :timestamp, :datetime 
  #     field :timezone, :string 
  #     field :start_checkin_id, :integer         # Hidden 
  #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end

  # config.model User do
  #   # Found associations:
  #     field :checkins, :has_many_association 
  #     field :legs, :has_many_association 
  #   # Found columns:
  #     field :id, :integer 
  #     field :email, :string 
  #     field :token, :string 
  #     field :name, :string 
  #     field :created_at, :datetime 
  #     field :updated_at, :datetime 
  #     field :foursquare_id, :string 
  #     field :last_email_sent, :datetime 
  #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end

end
