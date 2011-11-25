# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

# https://github.com/collectiveidea/delayed_job

# It is possible to disable delayed jobs for testing purposes. 
# Set Delayed::Worker.delay_jobs = false to execute all jobs realtime
# Setting this here will only run delayed jobs asynchronously in 
# production or development, making testing simpler
Delayed::Worker.delay_jobs = !Rails.env.test?