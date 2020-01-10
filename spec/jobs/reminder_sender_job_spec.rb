require 'rails_helper'

RSpec.describe ReminderSenderJob, type: :job do
  describe "#perform_later" do
    it "sends a reminder" do
      user = create(:user)

      ActiveJob::Base.queue_adapter = :test
      expect {
        ReminderSenderJob.perform_later(user)
      }.to have_enqueued_job
   end
 end
end
