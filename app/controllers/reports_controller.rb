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
      ],
      :order => [:id]
    )

    send_data_csv('customers.csv', @report.to_csv) if request.format == :csv
  end

  def invoices
    @report = Invoice.report_table(
      :all,
      :include => { :customer => { :methods => :short_code, :only => [] } },
      :methods => [ :total_labour, :total_parts ],
      :only => [
        :id,
        :date,
        'customer.short_code',
        :make_model,
        :registration,
        :total_labour,
        :total_parts,
        :environmental,
        :subtotal,
        :vat_rate,
        :vat,
        :mot,
        :total,
        :paid,
        :date_paid
      ],
      :order => [:id]
    )

    @report.rename_columns({
      'customer.short_code' => 'customer'
    })

    send_data_csv('invoices.csv', @report.to_csv) if request.format == :csv
  end
end
