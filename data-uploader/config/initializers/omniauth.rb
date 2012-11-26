require 'openid/store/filesystem'

ENV['GITHUB_KEY'] = '6d381a7e925074fe265f'
ENV['GITHUB_SECRET'] = '87df3bf1bde71029f746ef0c7c963dc20f3f1683'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'openid'
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user"
end

OmniAuth.config.on_failure = Proc.new do |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
end