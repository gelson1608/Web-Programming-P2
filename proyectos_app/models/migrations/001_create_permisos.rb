Sequel.migration do
    up do
        create_table(:permisos) do
            primary_key :id
            String :nombre, :null=>false, :size=>25
            String :llave, :null=>false, :size=>25
        end
    end

    down do
        drop_table(:permisos)
    end
end
