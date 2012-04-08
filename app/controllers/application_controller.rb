class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def send_data_csv(filename, csv_data)
    response.headers['Content-Length'] = csv_data.size.to_s
    send_data(
      csv_data,
      :type     => 'text/csv; charset=utf-8; header=present',
      :filename => filename
    )
  end

  def cleanup_attrs(attribute_hash)
    attribute_hash.each do |key,value|
      if value.is_a? String
        attribute_hash[key] = value.lstrip.rstrip
      elsif value.is_a? Hash
        attribute_hash[key] = cleanup_attrs(value)
      end
    end
    attribute_hash
  end
end
