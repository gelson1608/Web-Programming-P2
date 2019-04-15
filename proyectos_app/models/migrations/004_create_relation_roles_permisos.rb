Sequel.migration do
    up do
        alter_table :roles_permisos do
            add_foreign_key :permisos_id, :permisos, :on_delete=>:cascade
            add_foreign_key :roles_id, :roles
        end
    end

    down do
        drop_column :roles_permisos, :permisos_id, cascade:true
        drop_column :roles_permisos, :roles_id, cascade:true
    end
end
