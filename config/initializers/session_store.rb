# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_myfaves_session',
  :secret      => '8f8911168d6afca2dc2f810a8c6745d9a8481eee785226186e61a663099b62c0dc975f428560bceb37e74c5a96d9c8b239ccab4710e9b95419d16caa48409f36'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
