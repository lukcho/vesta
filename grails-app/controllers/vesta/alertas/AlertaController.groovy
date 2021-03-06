package vesta.alertas

import vesta.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Alerta
 */
class AlertaController extends Shield {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    public List<Alerta> getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Alerta.createCriteria()
            list = c.list(params) {
                eq("persona", session.usuario)
                isNull("fechaRecibido")
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("accion", "%" + params.search + "%")
                    ilike("controlador", "%" + params.search + "%")
                    ilike("mensaje", "%" + params.search + "%")
                }
            }
        } else {
            list = Alerta.findAllByPersonaAndFechaRecibidoIsNull(session.usuario, params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return alertaInstanceList: la lista de elementos filtrados, alertaInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def alertaInstanceList = getList(params, false)
        def alertaInstanceCount = getList(params, true).size()

        println("alerta " + alertaInstanceList)

        return [alertaInstanceList: alertaInstanceList, alertaInstanceCount: alertaInstanceCount]
    }

    /**
     * Acción que redirecciona a la acción necesaria según la alerta
     */
    def showAlerta = {
        def alerta = Alerta.get(params.id)
        alerta.fechaRecibido = new Date()
        alerta.save(flush: true)
        params.id = alerta.id_remoto
        def params = [:]
        if (alerta.parametros && alerta.parametros != "") {
            def parts = alerta.parametros.split("&")
            parts.each { part ->
                def p = part.split("=")
                params[p[0]] = p[1]
            }
        }

//        redirect(controller: alerta.controlador, action: alerta.accion, params: params)
        redirect(controller: alerta.controlador, action: alerta.accion, id: alerta.id_remoto, params: params)
    }

    /**
     * Acción llamada con ajax que marca una lista de alertas como leidas para que ya no se muestren en la lista
     */
    def marcarLeidas_ajax() {
        (params.ids.split(";")).each { id ->
            def alerta = Alerta.get(id.toLong())
            alerta.fechaRecibido = new Date()
            alerta.save(flush: true)
        }
        render "SUCCES"
    }
}
