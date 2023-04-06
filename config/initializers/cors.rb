Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any,
                  methods: %i[get post options put head delete],
                  expose: %w[Total Per-Page Link Page]
  end
end