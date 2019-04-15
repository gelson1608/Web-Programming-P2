require 'sinatra'
require 'mongo'
require_relative 'model/dao'

get '/usuarios/tablaUsuarios' do
  # Endpoint que devuelve todos los proyectos en json
  connector = MongoConnector.new("localhost:27017", "usuariosdb")
  usuarioDAO = UsuarioDAO.new(connector.client)

      # asignar = Hash.new
      # asignar = {
      #           'usuario' => 'pepe',
      #           'roles'   =>  {
      #                  'id'=> 2, 'rol'=> 'rol2',
      #                  'permisos' =>
      #                  {'id'=>1, 'nombre'=> 'xyz1', 'llave'=> 'xyz1'}}}
  listaPer = []
  usuarito = Usuario.new
  rolito = Rol.new
  permiso = Permiso.new
  permiso2 = Permiso.new
  permiso2.id = 1
  permiso2.nombre ='bruno'
  permiso2.llave= 'bhg5'
  permiso.id = 2
  permiso.nombre = 'permiso1'
  permiso.llave = 'xyz1'
  listaPer.push(permiso.to_hash)
  listaPer.push(permiso2.to_hash)

  puts permiso

  rolito.id = 1
  rolito.rol='rol1'
  rolito.permisos=listaPer

  usuarito.usuario = 'jaime liu'
  usuarito.roles = rolito.to_hash
  usuarioDAO.insert(usuarito)

  array1 = []
  array2 = usuarioDAO.list
  array2.each do |a|
    array1.push(a.to_hash)
  end
  hola=usuarioDAO.getNombre('andres liu')
  connector.close
  hola.usuario='rigoberto'
  usuarioDAO.modifyNombre(hola)
  hola.to_hash.to_json

  usuarioDAO.list
end

post '/usuarios/agregar' do
  connector = MongoConnector.new("localhost:27017", "usuariosdb")
  usuarioDAO = UsuarioDAO.new(connector.client)

  nuevoUser = JSON.parse request.body.read

  usuar = Usuario.new
  usuar.usuario = nuevoUser["usuario"]
  usuar.roles = nuevoUser["roles"]

  usuarioDAO.insert(usuar)
  connector.close

  hash_respuesta = {:msg => "OK"}
  hash_respuesta.to_json

  usuarioDAO.list
end
#falta
post '/usuarios/ver' do
  connector = MongoConnector.new("localhost:27017", "usuariosdb")
  proyectoDAO = ProyectoDAO.new(connector.client)

  hash_proyecto = JSON.parse request.body.read

  proyecto = Proyecto.new
  proyecto.id = hash_proyecto["id"]
  proyecto.nombre = hash_proyecto["nombre"]
  proyecto.anho = hash_proyecto["anho"]
  proyecto.ciclo = hash_proyecto["ciclo"]

  proyectoDAO.modify(proyecto)
  connector.close

  hash_respuesta = {:msg => "OK"}
  hash_respuesta.to_json
end
#
delete '/usuarios/eliminar' do
  connector = MongoConnector.new("localhost:27017", "usuariosdb")
  usuarioDAO = UsuarioDAO.new(connector.client)

  usuarioDAO.delete(params[:id])

  connector.close

  hash_respuesta = {:msg => "OK"}
  hash_respuesta.to_json
  usuarioDAO.list
end















# ====================
