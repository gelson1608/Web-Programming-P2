require 'sequel'
require 'pg'

class PGConnector
    attr_accessor :client
    def initialize(host, database, user, password)
        @client = Sequel.connect("postgres://#{user}:#{password}@#{host}/#{database}")
    end

    def close
        @client.disconnect
    end
end

class PermisosPGDAO
    attr_accessor :client
    def initialize(client)
        @client = client
    end
    def add(permiso)
        @client[:permisos].insert(
            :id=>20 ,
            :nombre=>permiso["nombre"],
            :llave=>permiso["llave"]
        )
    end
    def modify(permiso)
        @client[:permisos].where(
            :id=>permiso["id"]
        ).update(
            :nombre=>permiso["nombre"],
            :llave=>permiso["llave"]
        )
    end

    def list
        permisos = []
        @client[:permisos].all.each do |perm|
            permiso = Permisos.new
            permiso.id = perm[:id]
            permiso.nombre = perm[:nombre]
            permiso.llave = perm[:llave]
            permisos.push permiso
        end
        permisos
    end

    def delete(id)
        @client[:permisos].where(
            :id=>id
        ).delete
    end

end

class RolesPGDAO
    attr_accessor :client
    def initialize(client)
        @client = client
    end
    def add(rol)
        @client[:roles].insert(
            :nombre=>rol.nombre
        )
    end

    def list
        roles = []
        @client[:roles].all.each do |rolito|
            rol = Roles.new
            rol.id = rolito[:id]
            rol.nombre = rolito[:nombre]
            roles.push rol
        end
        roles
    end


    def delete(id)
        @client[:permisos].where(
            :id=>id
        ).delete
    end

    def getRoles_permisosId(id)
        permisos = []
        roles_permisos =[]
        @client[:roles_permisos].all.each do |rol_permisito|
            if rol_permisito[:roles_id].to_i == id.to_i
                rol_permisito[:permisos_id].all.each do |r_p|
                  roles_permisos.push r_p
                end
            end
        end

        @client[:permisos].all.each do |perm|
          roles_permisos.all.each do |p2|
            if perm[:id].to_i == p2.to_i
              permiso = Permisos.new
              permiso.id = perm[:id]
              permiso.nombre = perm[:nombre]
              permisos.push permiso
            end
          end
        end
        permisos
    end

    def getRoles_noPermisosId(id)
      permisos = []
      roles_permisos =[]
      @client[:roles_permisos].all.each do |rol_permisito|
          if rol_permisito[:roles_id].to_i == id.to_i
              rol_permisito[:permisos_id].all.each do |r_p|
                roles_permisos.push r_p
              end
          end
      end

      @client[:permisos].all.each do |perm|
        roles_permisos.all.each do |p2|
          if perm[:id].to_i != p2.to_i
            permiso = Permisos.new
            permiso.id = perm[:id]
            permiso.nombre = perm[:nombre]
            permisos.push permiso
          end
        end
      end
      permisos
    end
end

class UsuariosPGDAO
  attr_accessor :client
  def initialize(client)
      @client = client
  end

  def add(usuario)
      @client[:usuarios].insert(
          :usuario=>usuario.usuario,
          :contrasenia=>usuario.contrasenia,
          :correo=>usuario.correo
      )
  end

  def list
      usuarios = []
      @client[:usuarios].all.each do |user|
          usuario = Usuarios.new
          usuario.id = user[:id]
          usuario.usuario = user[:usuario]
          usuario.contrasenia = user[:contrasenia]
          usuario.correo = user[:correo]
          usuarios.push usuario
      end
      usuarios
  end


  def delete(id)
      @client[:usuarios].where(
          :id=>id
      ).delete
  end
end
