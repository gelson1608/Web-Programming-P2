Sequel.migration do
    up do
        create_table(:usuarios) do
            primary_key :id
            String :usuario, :null=>false, :size=>30
            String :contrasenia, :null=>false, :size=>30
            String :correo, :null=>false, :size=>45
        end
    end

    down do
        drop_table(:permisos)
    end
end
