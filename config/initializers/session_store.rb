# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oddpress_session',
  :secret      => '8eab50cf3a38bdc01fe8af656566e315ce8b2c74d60caaa8f82b7dbe1cbdb724aa7632ee787eace41900b9e9086457624aa39ed9fe87dfd1ca0b41004bc70b33'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
