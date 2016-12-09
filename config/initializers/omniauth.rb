OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "986978254757512","867101d8b10492fb7f29eaba5a5c4116"
end
