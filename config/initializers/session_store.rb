# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_Boutique_session',
  :secret => '67b0bdc43837fa0a261a666577594b03e1893d3a49fd40eb62b0a6d1c7d48c0e8e99bccf2435880f2dda07fa70c9778e1ea074543cdbcd3fab5bd016f72258dd',
  :expire_after => 604800
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#ActionController::Base.session_store =
Rails.application.config.session_store :active_record_store
