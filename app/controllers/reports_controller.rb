class ReportsController < ApplicationController
  respond_to :html, :csv

  def index
  end

  def customers
    @report = Customer.report_table(
      :all,
      :include => { :customer_title => { :only => 'title' } },
      :only => [
        :id,
        'customer_title.title',
        :first_name,
        :last_name,
        :company,
        :email,
        :telephone,
        :mobile
      ]
    )
    send_data_csv('customers.csv', @report.to_csv) if request.format == :csv
  end
end
