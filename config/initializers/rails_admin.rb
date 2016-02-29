if defined?(RailsAdmin)
  RailsAdmin.config do |config|
    config.excluded_models ||= []
    config.excluded_models << [
        'RailsAdminComments::Comment'
    ]
    config.excluded_models.flatten!
  end
end
