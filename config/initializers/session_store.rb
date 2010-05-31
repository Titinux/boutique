# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, { :key => '_Boutique_session',
                                                        :expire_after => 604800
                                                      }

Rails.application.config.session_store :active_record_store
