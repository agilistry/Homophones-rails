# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_agile_rails_session',
  :secret      => 'de11d26b6d8716b33ead42e7422e2c144364afaf5c560b41f4157523fe8fa2f9d8d2f775483ae49b62f6569989c1f754d4c5789c5abd8dcad69596ee9fdee24c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
