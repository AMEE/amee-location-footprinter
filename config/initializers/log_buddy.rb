# Use log buddy for logging, but make sure it's
# switched off for production, so we avoid the performance hit
# @see http://thinkrelevance.rubyforge.org/log_buddy/classes/LogBuddy.html
LogBuddy.init :disabled => Rails.env.production?