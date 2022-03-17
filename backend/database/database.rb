require 'sequel'

module Database
  CONNECTION = Sequel.connect('sqlite://my.db')
end
