class ClaimResponseProcessorWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'claims_response_and_parse'
  def perform(*args)
    puts "Need to write code to parse"
  end
end
