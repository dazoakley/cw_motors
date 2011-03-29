
Factory.define :customer do |u|
  u.customer_title_id { CustomerTitle.all.sort_by{ rand }[0].id }
  u.first_name        'John'
  u.last_name         'Doe'
  u.company           'Johns Welding'
  u.address_line1     '101 Some Street'
  u.town              'Some Town'
  u.county            'Some County'
  u.post_code         'SO15 1WH'
end

Factory.define :invoice do |i|
  i.association :customer
  i.invoice_status_id { InvoiceStatus.all.sort_by{ rand }[0].id }
  i.date              { DateTime.now() }
  i.mot               nil
  i.vat_rate          20.00
  i.subtotal          200.00
  i.vat               { |p| ( p.subtotal / 100 ) * p.vat_rate }
  i.total             { |p| p.subtotal + p.vat }
end