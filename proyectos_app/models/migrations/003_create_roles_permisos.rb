Sequel.migration do
    up do
        create_table(:roles_permisos) do
            primary_key :id
        end
    end

    down do
        drop_table(:roles_permisos)
    end
end
