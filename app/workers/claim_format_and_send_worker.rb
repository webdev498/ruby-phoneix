class ClaimFormatAndSendWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'claims_preprocess_and_request_send'
  def perform(*args)
    Claim.format_claim_and_send
  end
end
