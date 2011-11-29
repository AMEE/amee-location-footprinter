# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

# Be sure to restart your server when you modify this file.

Alf::Application.config.session_store :cookie_store, :key => '_personal_score_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Alf::Application.config.session_store :active_record_store
