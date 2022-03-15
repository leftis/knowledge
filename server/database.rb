require 'sequel'

DB = Sequel.connect('sqlite://my.db')

# Enable the firs time to create the table
# DB.create_table :presentations do
#   primary_key :id
#   String :title
#   String :author
#   String :status
#   Integer :presented_at
# end


# Models
# ------
class Presentation < Sequel::Model
end
