# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ([ENV['FRONT_WEB_URI']] + (Rails.env.development? ? [/localhost(:\d+)?\z/] : [])).compact
    resource '*', headers: :any,
                  methods: %i[get post options put head delete],
                  credentials: true
  end
end