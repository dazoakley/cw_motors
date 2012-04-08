class SearchController < ApplicationController
  def index
    redirect_to root_path if params['query'].blank?

    query = "%#{params['query']}%"

    @customers =
      Customer\
        .where('first_name ILIKE ? OR last_name ILIKE ? OR company ILIKE ?', query, query, query)\
        .order("last_name, first_name")

    @invoices_for_customers =
      Invoice\
        .where(:customer_id => @customers.map(&:id))\
        .order("date asc")

    @invoices =
      Invoice\
        .where('make_model ILIKE ? OR registration ILIKE ?', query, query)\
        .order("date asc")
  end
end
