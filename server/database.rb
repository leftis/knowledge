require 'sequel'
require 'sqlite3'

DB = Sequel.connect('sqlite://my.db')

# DB.create_table :presentations do
#   primary_key :id
#   String :title
#   String :author
#   String :status
#   Integer :presented_at
# end

class Presentation < Sequel::Model
end
