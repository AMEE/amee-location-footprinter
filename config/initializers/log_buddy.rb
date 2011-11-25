# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

# Use log buddy for logging, but make sure it's
# switched off for production, so we avoid the performance hit
# @see http://thinkrelevance.rubyforge.org/log_buddy/classes/LogBuddy.html
LogBuddy.init :disabled => Rails.env.production?