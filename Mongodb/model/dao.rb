require 'mongo'
require_relative 'models'

class MongoConnector
  attr_accessor :client

  def initialize(host, database)
    @client = Mongo::Client.new([host], :database=>database)
  end

  def close
    @client.close
  end
end

class UsuarioDAO
  def initialize(client)
    @client = client
  end

  def get(id)
    collection = @client["usuarios"]
    doc = collection.find(
      {:_id => BSON::ObjectId.from_string(id)}
    ).first
    usuario = Usuario.new
    usuario.nombre = doc[:nombre]
    usuario.rol = doc[:rol]
    usuario
  end

  def list
    collection = @client["usuarios"]
    arrUsuarios = []
    collection.find.each do |doc|
      usuario = Usuario.new
      usuario.usuario = doc[:usuario]
      usuario.roles = doc[:roles]
      arrUsuarios.push(usuario)
    end
    arrUsuarios
  end

  def insert(usuario)
    collection = @client["usuarios"]
    collection.insert_one(usuario.to_hash)
  end

  # def modify(usuario)
  #   collection = @client["usuarios"]
  #   collection.update_one(
  #     {:_id => BSON::ObjectId.from_string(usuario.id)},
  #     {:$set => usuario.to_hash}
  #   )
  # end

  def delete(id)
    collection = @client["usuarios"]
    collection.delete_one(
      {:_id => BSON::ObjectId.from_string(id)}
    )
  end

  def getNombre(nombre)
      collection = @client["usuarios"]
      doc = collection.find( {:usuario => nombre} ).first
      usuario = Usuario.new
      usuario.usuario = doc[:usuario]
      usuario.roles = doc[:roles]
      usuario
  end

  def deleteNombre(nombre)
    collection = @client["usuarios"]
    collection.delete_one(
      {:usuario => nombre}
    )
  end
  def modifyNombre(usuario)
    collection = @client["usuarios"]
    puts 'hola'
    collection.update_one(
      {:usuario => usuario.usuario},
      {:$set => usuario.to_hash}
    )
  end
end








# sdfsdfsf
