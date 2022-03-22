module Database
  CONNECTION = Sequel.connect('sqlite://my.db')
end

Database::CONNECTION.extension :date_arithmetic
# Require models
require 'presentation'
