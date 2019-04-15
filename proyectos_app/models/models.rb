class Permisos
  attr_accessor :id,:nombre, :llave
  def to_json
    {
      :nombre=>@nombre,
      :llave=>@llave
    }
  end
end

class Usuario
  attr_accessor :id, :usuario, :contrasenia, :correo
  def to_json
    {
      :id=>@id,
      :usuario=>@usuario,
      :contrasenia=>@contrasenia,
      :correo=>@correo
    }
  end
end

class Roles
  attr_accessor :id, :nombre
  def to_json
    {
      :id=>@id,
      :nombre=>@nombre
    }
  end
end

class Roles_permisos
  attr_accessor :id, :permisos_id, :roles_id
  def to_json
    {
      :id=>@id,
      :permisos_id=>@permisos_id,
      :roles_id=>@roles_id
    }
  end
end
