# == Schema Information
#
# Table name: transactions
#
#  id              :integer          not null, primary key
#  updated_at      :datetime
#  created_at      :datetime
#  claim_id        :integer
#  job_id          :string
#  status          :string
#  message         :string
#  time_to_process :integer
#

class Transaction < ActiveRecord::Base

end
