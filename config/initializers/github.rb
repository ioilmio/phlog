Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GH_ID'], ENV['GH_SECRET']
  provider :facebook, ENV['FB_ID'], ENV['FB_SECRET']
end
