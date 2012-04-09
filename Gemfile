source 'http://rubygems.org'

gem 'rails', '3.0.12'

platforms :ruby do
  gem 'pg'
end

platforms :jruby do
  gem 'activerecord-jdbc-adapter'
  gem 'jdbc-postgres', :require => false
  gem 'warbler', :require => false
end

gem 'haml'
gem 'foreigner'
gem 'formtastic'
gem 'kaminari'
gem 'ruport'
gem 'acts_as_reportable'
gem 'net-sftp'

group :test do
  gem 'shoulda'
  gem 'factory_girl_rails'
end

group :development do
  gem 'awesome_print'
end

