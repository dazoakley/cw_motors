
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
  i.association   :customer
  i.make_model    'Ford Cougar'
  i.registration  'KU45 4GB'
  i.mileage       65700
  i.date          { Date.today() }
  i.mot           45.00
  i.vat_rate      20.00
  i.subtotal      200.00
  i.vat           { |p| ( p.subtotal / 100 ) * p.vat_rate }
  i.total         { |p| p.mot + p.subtotal + p.vat }
  i.paid          true
end

Factory.define :invoice_labour do |l|
  l.association :invoice
  l.details     'Some random bit of work'
  l.price       20.75
end

Factory.define :invoice_part do |p|
  p.association :invoice
  p.details     'Some random bit of kit'
  p.price       42.25
end