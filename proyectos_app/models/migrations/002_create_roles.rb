Sequel.migration do
    up do
        create_table(:roles) do
            primary_key :id
            String :nombre, :null=>false, :size=>25
        end
    end

    down do
        drop_table(:roles)
    end
end
