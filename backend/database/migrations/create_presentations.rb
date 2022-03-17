require 'sequel'

Sequel.migration do
  up do
    create_table(:presentations) do
      primary_key :id
      String :title, null: false
      String :author, null: false
      String :status, null: false
      Integer :presented_at
    end
  end

  down do
    drop_table(:presentations)
  end
end