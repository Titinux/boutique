# Be sure to restart your server when you modify this file.

#Boutique::Application.config.session_store :cookie_store, key: '_boutique_session', expire_after: 604800

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Boutique::Application.config.session_store :active_record_store, expire_after: 7.days
