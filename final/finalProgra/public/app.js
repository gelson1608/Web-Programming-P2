//Mostrar todos los permisos
var listarTablaPermisos = function () {
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "tablaPermisos" que le devuelve un arreglo con todos los permisos
    req.open("GET", "http://127.0.0.1:4567/permisos/tablaPermisos")
    req.onreadystatechange = resListarTablaPermisos
    req.send()
}

//Funcion que ejecuta al ejecutar la conexion "listarTablaPermisos"
var resListarTablaPermisos = function (evt) {
    if (evt.target.readyState == 4 && evt.target.status == 200) {
        //var permisos = [{ "id": 1452, "nombre": "Crear usuarios", "llave": "crear_usuario" }, { "id": 5824, "nombre": "Editar usuarios", "llave": "editar_usuario" }]
        var permisos = JSON.parse(evt.target.response)

        document.getElementById("tabla-gestion-permisos").innerHTML = ""
        //Se recorre todos los permisos
        permisos.forEach(function (permiso) {
            //Se crea la fila
            var tr = document.createElement("tr")
            tr.id = permiso.id
            //Se crea las columnas
            var td1 = document.createElement("td")
            td1.innerHTML = permiso.nombre
            var td2 = document.createElement("td")
            td2.innerHTML = permiso.llave
            var td3 = document.createElement("td")
            var eliminar = document.createElement("i")
            eliminar.className = "fa fa-trash icon-action"
            eliminar.setAttribute("aria-hidden", "true")
            eliminar.onclick = eliminarPermiso
            var editar = document.createElement("i")
            editar.className = "fa fa-pencil icon-action"
            editar.setAttribute("aria-hidden", "true")
            editar.onclick = editarPermiso
            //Se agregan las columnas a la fila correspondiente
            td3.appendChild(eliminar)
            td3.appendChild(editar)
            tr.appendChild(td1)
            tr.appendChild(td2)
            tr.appendChild(td3)
            //Se agregar el tr al HTML
            document.getElementById("tabla-gestion-permisos").appendChild(tr)
        })
    }
}

var eliminarPermiso = function (evt) {
    //Trae el tr padre
    var tr = evt.target.parentElement.parentElement;
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "eliminar" que elimina un permiso
    req.open("POST", "http://127.0.0.1:4567/permisos/eliminar")
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            listarTablaPermisos()
        }
    }
    // Envia el id del tr padre para eliminar toda la fila
    req.send(tr.id)
}

var editarPermiso = function (evt) {

    //Crea una copia de cada nodo por si se da click en cancelar
    var trCopia = evt.target.parentElement.parentElement
    var td1Copia = trCopia.firstChild.cloneNode(true)
    var td2Copia = trCopia.firstChild.nextSibling.cloneNode(true)
    var td3Copia = trCopia.firstChild.nextSibling.nextSibling.cloneNode(true)
    td3Copia.firstChild.onclick = eliminarPermiso
    td3Copia.firstChild.nextSibling.onclick = editarPermiso

    //Trae el tr padre para modificarlo
    var tr = evt.target.parentElement.parentElement

    //Para editar un permiso se insrta inputs 
    var inputNombre = document.createElement("input")
    inputNombre.id = "nombrePermisoAct"
    var inputLlave = document.createElement("input")
    inputLlave.id = "llavePermisoAct"
    var agregar = document.createElement("i")
    agregar.className = "fa fa-plus icon-action"
    agregar.setAttribute("aria-hidden", "true")
    agregar.onclick = function () {
        var nombre = document.getElementById("nombrePermisoAct").value
        var llave = document.getElementById("llavePermisoAct").value
        var permiso = { "id": tr.id, "nombre": nombre, "llave": llave }
        if (nombre != "" && llave != "") {
            var req = new XMLHttpRequest()
            req.open("POST", "http://127.0.0.1:4567/permisos/editar")
            req.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    listarTablaPermisos()
                }
            }
            req.send(JSON.stringify(permiso))
        }
    }
    var cancelar = document.createElement("i")
    cancelar.className = "fa fa-times icon-action"
    cancelar.setAttribute("aria-hidden", "true")
    cancelar.onclick = function () {
        tr.replaceChild(td1Copia, tr.firstChild)
        tr.replaceChild(td2Copia, tr.firstChild.nextSibling)
        tr.replaceChild(td3Copia, tr.firstChild.nextSibling.nextSibling)
    }

    //Se inserta los inputs
    tr.firstChild.innerHTML = ""
    tr.firstChild.appendChild(inputNombre)
    tr.firstChild.nextSibling.innerHTML = ""
    tr.firstChild.nextSibling.appendChild(inputLlave)
    tr.firstChild.nextSibling.nextSibling.innerHTML = ""
    tr.firstChild.nextSibling.nextSibling.appendChild(agregar)
    tr.firstChild.nextSibling.nextSibling.appendChild(cancelar)
}

var agregarNuevoPermiso = function () {
    document.getElementById("crearRegistro").addEventListener("click", function () {
        var nombre = document.getElementById("nuevo-nombre-permiso").value
        var llave = document.getElementById("nueva-llave-permiso").value
        var permiso = { "nombre": nombre, "llave": llave }
        if (nombre != "" && llave != "") {
            var req = new XMLHttpRequest()
            req.open("POST", "http://127.0.0.1:4567/permisos/agregar")
            req.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    listarTablaPermisos()
                    document.getElementById("agregar-permiso").click()
                    document.getElementById("nuevo-nombre-permiso").value=""
                    document.getElementById("nueva-llave-permiso").value=""
                }
            }
            req.send(JSON.stringify(permiso))
        }
    })

    document.getElementById("cancelarRegistro").addEventListener("click", function () {
        document.getElementById("agregar-permiso").click()
    })
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

//Mostrar todos los roles
var listarTablaRoles = function () {
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "tablaRoles" que le devuelve un arreglo con todos los roles
    req.open("GET", "http://127.0.0.1:4567/roles/tablaRoles")
    req.onreadystatechange = resListarTablaRoles
    req.send()
}

//Funcion que ejecuta al ejecutar la conexion "listarTablaRoles"
var resListarTablaRoles = function (evt) {
    //if (evt.target.readyState == 4 && evt.target.status == 200) {
    var roles = [{ "id": 1519815, "nombre": "Rol 1" }, { "id": 73952, "nombre": "Rol 2" }]
    //var roles = JSON.parse(evt.target.response)
    document.getElementById("tabla-gestion-roles").innerHTML = ""
    //Se recorre todos los roles
    roles.forEach(function (rol) {
        //Se crea la fila
        var tr = document.createElement("tr")
        tr.id = rol.id
        //Se crea las columnas
        var td1 = document.createElement("td")
        td1.innerHTML = rol.nombre

        var td2 = document.createElement("td")

        var ver = document.createElement("i")
        ver.className = "fa fa-eye icon-action"
        ver.setAttribute("aria-hidden", "true")
        ver.onclick = verRol

        var eliminar = document.createElement("i")
        eliminar.className = "fa fa-trash icon-action"
        eliminar.setAttribute("aria-hidden", "true")
        eliminar.onclick = eliminarRol

        var editar = document.createElement("i")
        editar.className = "fa fa-pencil icon-action"
        editar.setAttribute("aria-hidden", "true")
        editar.onclick = editarRol
        //Se agregan las columnas a la fila correspondiente
        td2.appendChild(ver)
        td2.appendChild(eliminar)
        td2.appendChild(editar)

        tr.appendChild(td1)
        tr.appendChild(td2)
        //Se agregar el tr al HTML
        document.getElementById("tabla-gestion-roles").appendChild(tr)
    })
    //}

}

var eliminarRol = function (evt) {
    //Trae el tr padre
    var tr = evt.target.parentElement.parentElement;
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "eliminar" que elimina un permiso
    req.open("POST", "http://127.0.0.1:4567/roles/eliminar")
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            listarTablaRoles()
        }
    }
    // Envia el id del tr padre para eliminar toda la fila
    req.send(tr.id)
}

var editarRol = function (evt) {
    //Crea una copia de cada nodo por si se da click en cancelar
    var trCopia = evt.target.parentElement.parentElement
    var td1Copia = trCopia.firstChild.cloneNode(true)
    var td2Copia = trCopia.firstChild.nextSibling.cloneNode(true)
    td2Copia.firstChild.onclick = verRol
    td2Copia.firstChild.nextSibling.onclick = eliminarRol
    td2Copia.firstChild.nextSibling.nextSibling.onclick = editarRol

    //Trae el tr padre para modificarlo
    var tr = evt.target.parentElement.parentElement

    //Para editar un permiso se insrta inputs 
    var inputNombre = document.createElement("input")
    var agregar = document.createElement("i")
    agregar.className = "fa fa-plus icon-action"
    agregar.setAttribute("aria-hidden", "true")
    agregar.onclick = function () {
        //AJAX
    }
    var cancelar = document.createElement("i")
    cancelar.className = "fa fa-times icon-action"
    cancelar.setAttribute("aria-hidden", "true")
    cancelar.onclick = function () {
        tr.replaceChild(td1Copia, tr.firstChild)
        tr.replaceChild(td2Copia, tr.firstChild.nextSibling)
    }

    //Se inserta los inputs
    tr.firstChild.innerHTML = ""
    tr.firstChild.appendChild(inputNombre)
    tr.firstChild.nextSibling.innerHTML = ""
    tr.firstChild.nextSibling.appendChild(agregar)
    tr.firstChild.nextSibling.appendChild(cancelar)
}

var verRol = function (evt) {
    //Trae el tr padre
    var tr = evt.target.parentElement.parentElement;
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "eliminar" que elimina un permiso
    req.open("POST", "http://127.0.0.1:4567/roles/ver")
    req.onreadystatechange = asignarPermisos
    // Envia el id del tr padre para eliminar toda la fila
    req.send(tr.id)
}

var asignarPermisos = function (evt) {
    if (evt.target.readyState == 4 && evt.target.status == 200) {
        var permisos = [[{ "id": 8798, "nombre": "Rol 1" }, { "id": 1542, "nombre": "Rol 2" }], [{ "id": 9865, "nombre": "Rol 3" }, { "id": 666, "nombre": "Rol 4" }]]
        //var permisos = JSON.parse(evt.target.response)
        document.getElementById("select-asignar-permisos").innerHTML = ""

        permisos[0].forEach(function (permiso) {
            var option = document.createElement("option")
            option.setAttribute("selected", "selected")
            option.id = permiso.id
            option.innerHTML = permiso.nombre
            document.getElementById("select-asignar-permisos").appendChild(option)
        })

        permisos[1].forEach(function (permiso) {
            var option = document.createElement("option")
            option.id = permiso.id
            option.innerHTML = permiso.nombre
            document.getElementById("select-asignar-permisos").appendChild(option)
        })

    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

//Mostrar todos los usuarios
var listarTablaUsuarios = function () {
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "tablaUsuarios" que le devuelve un arreglo con todos los usuarios
    req.open("GET", "http://127.0.0.1:4567/usuarios/tablaUsuarios")
    req.onreadystatechange = resListarTablaUsuarios
    req.send()
}

var resListarTablaUsuarios = function (evt) {
    //if (evt.target.readyState == 4 && evt.target.status == 200) {
    var usuarios = [{ "id": 3344, "usuario": "pepito", "contrasenia": "pepes", "correo": "p@p.com" }, { "id": 3232, "usuario": "cesar", "contrasenia": "cesardelgado", "correo": "c@c.com" }]
    //var usuarios = JSON.parse(evt.target.response)
    document.getElementById("tabla-gestion-usuarios").innerHTML = ""
    //Se recorre todos los usuarios
    usuarios.forEach(function (usuario) {
        //Se crea la fila
        var tr = document.createElement("tr")
        tr.id = usuario.id
        //Se crea las columnas
        var td1 = document.createElement("td")
        td1.innerHTML = usuario.usuario

        var td2 = document.createElement("td")
        td2.innerHTML = usuario.correo

        var td3 = document.createElement("td")
        td3.innerHTML = "**********"

        var td4 = document.createElement("td")

        var ver = document.createElement("i")
        ver.className = "fa fa-eye icon-action"
        ver.setAttribute("aria-hidden", "true")
        ver.onclick = verUsuario

        var eliminar = document.createElement("i")
        eliminar.className = "fa fa-trash icon-action"
        eliminar.setAttribute("aria-hidden", "true")
        eliminar.onclick = eliminarUsuario

        var editar = document.createElement("i")
        editar.className = "fa fa-pencil icon-action"
        editar.setAttribute("aria-hidden", "true")
        editar.onclick = editarUsuario
        //Se agregan las columnas a la fila correspondiente
        td4.appendChild(ver)
        td4.appendChild(eliminar)
        td4.appendChild(editar)

        tr.appendChild(td1)
        tr.appendChild(td2)
        tr.appendChild(td3)
        tr.appendChild(td4)
        //Se agregar el tr al HTML
        document.getElementById("tabla-gestion-usuarios").appendChild(tr)
    })
    //}

}

var eliminarUsuario = function (evt) {
    //Trae el tr padre
    var tr = evt.target.parentElement.parentElement;
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "eliminar" que elimina un permiso
    req.open("POST", "http://127.0.0.1:4567/usuarios/eliminar")
    req.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            listarTablaUsuarios()
        }
    }
    // Envia el id del tr padre para eliminar toda la fila
    req.send(tr.id)
}

var editarUsuario = function (evt) {
    //Crea una copia de cada nodo por si se da click en cancelar
    var trCopia = evt.target.parentElement.parentElement
    var td1Copia = trCopia.firstChild.cloneNode(true)
    var td2Copia = trCopia.firstChild.nextSibling.cloneNode(true)
    var td3Copia = trCopia.firstChild.nextSibling.nextSibling.cloneNode(true)
    var td4Copia = trCopia.firstChild.nextSibling.nextSibling.nextSibling.cloneNode(true)
    td4Copia.firstChild.onclick = verUsuario
    td4Copia.firstChild.nextSibling.onclick = eliminarUsuario
    td4Copia.firstChild.nextSibling.nextSibling.onclick = editarUsuario

    //Trae el tr padre para modificarlo
    var tr = evt.target.parentElement.parentElement

    //Para editar un permiso se insrta inputs 
    var inputUsuario = document.createElement("input")
    var inputCorreo = document.createElement("input")
    var inputContrasenia = document.createElement("input")

    var agregar = document.createElement("i")
    agregar.className = "fa fa-plus icon-action"
    agregar.setAttribute("aria-hidden", "true")
    agregar.onclick = function () {
        //AJAX
    }
    var cancelar = document.createElement("i")
    cancelar.className = "fa fa-times icon-action"
    cancelar.setAttribute("aria-hidden", "true")
    cancelar.onclick = function () {
        tr.replaceChild(td1Copia, tr.firstChild)
        tr.replaceChild(td2Copia, tr.firstChild.nextSibling)
        tr.replaceChild(td3Copia, tr.firstChild.nextSibling.nextSibling)
        tr.replaceChild(td4Copia, tr.firstChild.nextSibling.nextSibling.nextSibling)
    }

    //Se inserta los inputs
    tr.firstChild.innerHTML = ""
    tr.firstChild.appendChild(inputUsuario)
    tr.firstChild.nextSibling.innerHTML = ""
    tr.firstChild.nextSibling.appendChild(inputCorreo)
    tr.firstChild.nextSibling.nextSibling.innerHTML = ""
    tr.firstChild.nextSibling.nextSibling.appendChild(inputContrasenia)
    tr.firstChild.nextSibling.nextSibling.nextSibling.innerHTML = ""
    tr.firstChild.nextSibling.nextSibling.nextSibling.appendChild(agregar)
    tr.firstChild.nextSibling.nextSibling.nextSibling.appendChild(cancelar)
}

var verUsuario = function (evt) {
    //Trae el tr padre
    var tr = evt.target.parentElement.parentElement;
    //Conexion AJAX
    var req = new XMLHttpRequest()
    //Peticion al servicio "eliminar" que elimina un permiso
    req.open("POST", "http://127.0.0.1:4567/usuarios/ver")
    req.onreadystatechange = asignarRoles
    // Envia el id del tr padre para eliminar toda la fila
    req.send(tr.id)
}

var asignarRoles = function (evt) {
    if (evt.target.readyState == 4 && evt.target.status == 200) {
        var roles = [[{ "id": 8798, "nombre": "Rol 1" }, { "id": 1542, "nombre": "Rol 2" }], [{ "id": 9865, "nombre": "Rol 3" }, { "id": 666, "nombre": "Rol 4" }]]
        //var roles = JSON.parse(evt.target.response)
        document.getElementById("select-asignar-roles").innerHTML = ""

        roles[0].forEach(function (permiso) {
            var option = document.createElement("option")
            option.setAttribute("selected", "selected")
            option.id = permiso.id
            option.innerHTML = permiso.nombre
            document.getElementById("select-asignar-roles").appendChild(option)
        })

        roles[1].forEach(function (permiso) {
            var option = document.createElement("option")
            option.id = permiso.id
            option.innerHTML = permiso.nombre
            document.getElementById("select-asignar-roles").appendChild(option)
        })
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

var main = function () {
    listarTablaPermisos()
    agregarNuevoPermiso()
    //listarTablaRoles()
    //listarTablaUsuarios()


}

window.onload = main