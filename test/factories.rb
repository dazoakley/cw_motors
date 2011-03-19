
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