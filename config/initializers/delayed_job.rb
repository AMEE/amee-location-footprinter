# https://github.com/collectiveidea/delayed_job

# It is possible to disable delayed jobs for testing purposes. 
# Set Delayed::Worker.delay_jobs = false to execute all jobs realtime
# Setting this here will only run delayed jobs asynchronously in 
# production or development, making testing simpler
Delayed::Worker.delay_jobs = !Rails.env.test?