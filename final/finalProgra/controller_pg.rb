require 'sinatra'
require_relative 'models/models'
require_relative 'models/dao_pg'
require_relative 'config'

get '/' do
  erb :ef
end

get '/permisos/tablaPermisos' do
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisos = permisoDAO.list
  hashPermiso = []
  permisos.each do |permiso|
    hashPermiso.push(permiso.to_hash)
  end
  connector.close
  hashPermiso.to_json
end

post '/permisos/eliminar' do
  id = request.body.read
  puts id
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisoDAO.delete id
  connector.close
  ""
end

post '/permisos/editar' do
  permiso = JSON.parse(request.body.read)
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisoDAO.modify permiso
  connector.close
  ""
end

post '/permisos/agregar' do
  permiso = JSON.parse(request.body.read)
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisoDAO.add permiso
  connector.close
  ""
end

get '/roles/tablaRoles' do
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  rolDAO = RolesPGDAO.new connector.client
  roles = rolDAO.list
  hashRol = []
  roles.each do |rol|
    hashRol.push(rol.to_hash)
  end
  connector.close
  return hashRol.to_json
end

post '/roles/eliminar' do
  id = request.body.read
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  rolDAO = RolesPGDAO.new connector.client
  rolDAO.delete id
  connector.close

  redirect '/roles/tablaRoles'
end

post '/roles/agregar' do
  rol = JSON.parse(request.body.read)
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  rolDAO = RolesPGDAO.new connector.client
  rolDAO.add rol
  connector.close

  redirect '/roles/tablaRoles'
end

post '/roles/ver' do
  id = request.body.read
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  rolDAO = RolesPGDAO.new connector.client
  permisosT = rolDAO.getRoles_permisosId id
  permisosF = rolDAO.getRoles_noPermisosId id
  permisosTotales = []
  permisosTotales.push permisosT
  permisosTotales.push permisosF
  connector.close
  return permisosTotales.to_json
end

get '/usuarios/tablaUsuarios' do
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  usuarioDAO = UsuariosPGDAO.new connector.client
  usuarios = usuarioDAO.list
  hashUsuario = []
  usuarios.each do |usuario|
    hashUsuario.push(usuario.to_hash)
  end
  connector.close
  return hashUsuario.to_json
end

post '/usuarios/eliminar' do
  id = request.body.read
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  usuarioDAO = UsuariosPGDAO.new connector.client
  usuarioDAO.delete id
  connector.close
  redirect '/usuarios/tablaUsuarios'
end

post '/usuarios/agregar' do
  usuario = JSON.parse(request.body.read)
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  usuarioDAO = UsuariosPGDAO.new connector.client
  usuarioDAO.add usuario
  connector.close

  redirect '/usuarios/tablaUsuarios'
end
