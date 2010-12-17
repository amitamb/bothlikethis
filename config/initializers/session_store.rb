# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bothlikethis_session',
  :secret      => 'a388d42cbebf33059d4d4dd8dae018ef14152c699cdf919868103a2ac6f50bdffb5d0bc93fb22b14240589852fdcd03f393b3b30450996206fe9c1bb749d8d40'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
