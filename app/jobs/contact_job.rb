class ContactJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(content)
    ContactMailer.with(:content => content).send_contact.deliver_later
  end
end
