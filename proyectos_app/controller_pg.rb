require 'sinatra'
require_relative 'models/models'
require_relative 'models/dao_pg'
require_relative 'config'

get '/' do
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  cursoDAO = CursoPGDAO.new connector.client
  cursos = cursoDAO.list
  connector.close

  erb :ef, :locals=>{:tipo=>'nuevo', :cursos=>cursos}
end

get '/permisos/tablaPermisos' do
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisos = permisoDAO.list
  return permisos.to_json
  connector.close
end

post '/permisos/eliminar' do
  id = request.body.read
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisoDAO.delete id
  connector.close

  redirect '/permisos/tablaPermisos'
end

post '/permisos/editar' do
  permiso = JSON.parse(request.body.read)
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisoDAO.modify permiso
  connector.close

  redirect '/permisos/tablaPermisos'
end

post '/permisos/agregar' do
  permiso = JSON.parse(request.body.read)
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  permisoDAO = PermisosPGDAO.new connector.client
  permisoDAO.add permiso
  connector.close

  redirect '/permisos/tablaPermisos'
end

get '/roles/tablaRoles' do
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  rolDAO = RolesPGDAO.new connector.client
  roles = rolDAO.list
  return roles.to_json
  connector.close
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

  redirect '/permisos/tablaPermisos'
end

post '/roles/tablaRoles' do
  id = request.body.read
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  rolDAO = RolesPGDAO.new connector.client
  roles = rolDAO.getRoles_permisosId
  return roles.to_json
  connector.close
end

get '/usuarios/tablaUsuarios' do
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  usuarioDAO = UsuariosPGDAO.new connector.client
  usuarios = usuarioDAO.list
  return usuarios.to_json
  connector.close
end

post '/usuarios/eliminar' do
  id = request.body.read
  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
  usuarioDAO = UsuariosPGDAO.new connector.client
  usuarioDAO.delete id
  connector.close
end

#get '/roles/tablaRoles' do
#  connector = PGConnector.new PG_HOST, PG_DATABASE, PG_USER, PG_PASSWORD
#  rolDAO = RolesPGDAO.new connector.client
#  roles = rolDAO.list
#  permisos = rolDAO.listpermisos
#  r_p =[]
#  r_p.push roles
#  r_p.push permisos
#  return r_p.to_json
#  connector.close
#end
