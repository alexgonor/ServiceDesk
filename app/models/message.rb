class Message < ApplicationRecord
  belongs_to :user
  # after_create_commit { BroadcastMessageJob.perform_now self }
end
