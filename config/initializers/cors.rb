Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Replace '*' with your frontend URL in production (e.g. 'https://yourfrontend.com')

    resource '*',
      headers: :any,
      methods: [ :get, :post, :options, :head ],
      expose: ['Authorization']  # Optional, if you're sending tokens via headers
  end
end
