job_type :sidekiq, "cd :path && RAILS_ENV=:environment /usr/local/bin/bundle exec /usr/local/bin/sidekiq-client :task :output"

set :output, error: 'error.log', standard: 'cron.log'
set :environment, :development

every 1.minute do
  sidekiq 'push TicketWorker'
end
