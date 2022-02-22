class ContactServices::Send < ApplicationService
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def call
    ContactJob.perform_later(@content)
  end
end
