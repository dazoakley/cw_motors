source 'http://rubygems.org'

gem 'rails', '3.0.10'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

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
gem 'awesome_print'

group :test do
  gem 'shoulda'
  gem 'factory_girl_rails'
end

