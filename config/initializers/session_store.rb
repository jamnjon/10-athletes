if Rails.env.production?
  Rails.application.config.session_store :cookie_store, key: '_10-athletes', domain: :all
else
  Rails.application.config.session_store :cookie_store, key: '_10-athletes'
end
