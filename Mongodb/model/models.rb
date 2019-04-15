class Usuario
  attr_accessor :usuario, :roles

  def to_hash
    {
      :usuario => @usuario,
      :roles => @roles
    }
  end
end

class Rol
  attr_accessor :id, :rol, :permisos
  def to_hash
    {
      :id => @id,
      :rol => @rol,
      :permisos => @permisos
    }
  end
end

class Permiso
  attr_accessor :id, :nombre, :llave
  def to_hash
    {
      :id => @id,
      :nombre => @nombre,
      :llave => @llave
    }
  end
end
