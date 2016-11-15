class HomeController < ApplicationController

  def index
    @left_tab = ["Accounts","Users","Billing","Admin"]
    @account = Account.new
    @account_records = []
  end
end
