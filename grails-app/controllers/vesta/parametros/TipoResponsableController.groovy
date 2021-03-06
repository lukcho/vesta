package vesta.parametros

import org.springframework.dao.DataIntegrityViolationException
import vesta.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de TipoResponsable
 */
class TipoResponsableController extends Shield {

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
    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = TipoResponsable.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = TipoResponsable.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return tipoResponsableInstanceList: la lista de elementos filtrados, tipoResponsableInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def tipoResponsableInstanceList = getList(params, false)
        def tipoResponsableInstanceCount = getList(params, true).size()
        return [tipoResponsableInstanceList: tipoResponsableInstanceList, tipoResponsableInstanceCount: tipoResponsableInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return tipoResponsableInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def tipoResponsableInstance = TipoResponsable.get(params.id)
            if (!tipoResponsableInstance) {
                render "ERROR*No se encontró TipoResponsable."
                return
            }
            return [tipoResponsableInstance: tipoResponsableInstance]
        } else {
            render "ERROR*No se encontró TipoResponsable."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return tipoResponsableInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def tipoResponsableInstance = new TipoResponsable()
        if (params.id) {
            tipoResponsableInstance = TipoResponsable.get(params.id)
            if (!tipoResponsableInstance) {
                render "ERROR*No se encontró TipoResponsable."
                return
            }
        }
        tipoResponsableInstance.properties = params
        return [tipoResponsableInstance: tipoResponsableInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def tipoResponsableInstance = new TipoResponsable()
        if (params.id) {
            tipoResponsableInstance = TipoResponsable.get(params.id)
            if (!tipoResponsableInstance) {
                render "ERROR*No se encontró TipoResponsable."
                return
            }
        }
        tipoResponsableInstance.properties = params
        if (!tipoResponsableInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar TipoResponsable: " + renderErrors(bean: tipoResponsableInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de TipoResponsable exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def tipoResponsableInstance = TipoResponsable.get(params.id)
            if (!tipoResponsableInstance) {
                render "ERROR*No se encontró TipoResponsable."
                return
            }
            try {
                tipoResponsableInstance.delete(flush: true)
                render "SUCCESS*Eliminación de TipoResponsable exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar TipoResponsable"
                return
            }
        } else {
            render "ERROR*No se encontró TipoResponsable."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigo
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigo_ajax() {
        params.codigo = params.codigo.toString().trim()
        if (params.id) {
            def obj = TipoResponsable.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render TipoResponsable.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render TipoResponsable.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

}
