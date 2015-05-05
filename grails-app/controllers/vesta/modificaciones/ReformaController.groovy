package vesta.modificaciones

import vesta.alertas.Alerta
import vesta.avales.EstadoAval
import vesta.parametros.TipoElemento
import vesta.parametros.UnidadEjecutora
import vesta.parametros.poaPac.Anio
import vesta.parametros.poaPac.Presupuesto
import vesta.poa.Asignacion
import vesta.proyectos.Categoria
import vesta.proyectos.MarcoLogico
import vesta.proyectos.ModificacionAsignacion
import vesta.proyectos.Proyecto
import vesta.seguridad.Firma
import vesta.seguridad.Persona
import vesta.seguridad.Prfl
import vesta.seguridad.Sesn
import vesta.seguridad.Shield


/**
 * Controlador que muestra las pantallas de manejo de Reforma
 */
class ReformaController extends Shield {

    def firmasService

    /**
     * Acción que muestra los diferentes tipos de reforma posibles y permite seleccionar uno para comenzar el proceso
     */
    def reformas() {

    }

    /**
     * Acción que permite realizar una solicitud de reforma a asignaciones existentes
     */
    def existente() {
        def proyectos = []
        def actual
        Asignacion.list().each {
//            println "p "+proyectos
            def p = it.marcoLogico.proyecto
            if (!proyectos?.id.contains(p.id)) {
                proyectos.add(p)
            }
        }
        if (params.anio) {
            actual = Anio.get(params.anio)
        } else {
            actual = Anio.findByAnio(new Date().format("yyyy"))
        }

        proyectos = proyectos.sort { it.nombre }

        def proyectos2 = Proyecto.findAllByAprobadoPoa('S', [sort: 'nombre'])

        def proyectos3 = Proyecto.findAllByAprobadoPoaAndUnidadAdministradora('S', session.unidad, [sort: 'nombre'])

        def campos = ["numero": ["Número", "string"], "descripcion": ["Descripción", "string"]]
//        println "pro "+proyectos
//        def unidad = UnidadEjecutora.findByCodigo("DPI") // DIRECCIÓN DE PLANIFICACIÓN E INVERSIÓN
//        def personasFirmas = Persona.findAllByUnidad(unidad)
//        def gerentes = Persona.findAllByUnidad(unidad.padre)
        def firmas = firmasService.listaFirmasCombos()

        def total = 0

        def reforma = null, detalles = [], editable = true
        if (params.id) {
            editable = false
            reforma = Reforma.get(params.id)
            detalles = DetalleReforma.findAllByReforma(reforma)
            def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")
            def devuelto = EstadoAval.findByCodigo("D01")
            def estados = [solicitadoSinFirma, devuelto]
            if (estados.contains(reforma.estado)) {
                editable = true
            }
            if (detalles.size() > 0) {
                total = detalles.sum { it.valor }
            }
        }

        return [proyectos      : proyectos3, proyectos2: proyectos3, actual: actual, campos: campos, personas: firmas.directores,
                personasGerente: firmas.gerentes, total: total, editable: editable, reforma: reforma, detalles: detalles]
    }

    /**
     * Acción que permite realizar una solicitud de reforma a nueva partida
     */
    def partida() {
        def proyectos = []
        def actual
        Asignacion.list().each {
//            println "p "+proyectos
            def p = it.marcoLogico.proyecto
            if (!proyectos?.id.contains(p.id)) {
                proyectos.add(p)
            }
        }
        if (params.anio) {
            actual = Anio.get(params.anio)
        } else {
            actual = Anio.findByAnio(new Date().format("yyyy"))
        }

        proyectos = proyectos.sort { it.nombre }

        def proyectos2 = Proyecto.findAllByAprobadoPoa('S', [sort: 'nombre'])

        def proyectos3 = Proyecto.findAllByAprobadoPoaAndUnidadAdministradora('S', session.unidad, [sort: 'nombre'])

        def campos = ["numero": ["Número", "string"], "descripcion": ["Descripción", "string"]]
//        println "pro "+proyectos
//        def unidad = UnidadEjecutora.findByCodigo("DPI") // DIRECCIÓN DE PLANIFICACIÓN E INVERSIÓN
//        def personasFirmas = Persona.findAllByUnidad(unidad)
//        def gerentes = Persona.findAllByUnidad(unidad.padre)
        def firmas = firmasService.listaFirmasCombos()

        def total = 0

        def reforma = null, detalles = [], editable = true
        if (params.id) {
            editable = false
            reforma = Reforma.get(params.id)
            detalles = DetalleReforma.findAllByReforma(reforma)
            def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")
            def devuelto = EstadoAval.findByCodigo("D01")
            def estados = [solicitadoSinFirma, devuelto]
            if (estados.contains(reforma.estado)) {
                editable = true
            }
            if (detalles.size() > 0) {
                total = detalles.sum { it.valor }
            }
        }

        return [proyectos      : proyectos3, proyectos2: proyectos3, actual: actual, campos: campos, personas: firmas.directores,
                personasGerente: firmas.gerentes, total: total, editable: editable, reforma: reforma, detalles: detalles]
    }

    /**
     * Acción que permite realizar una solicitud de reforma a nueva actividad
     */
    def actividad() {
        def proyectos = []
        def actual
        Asignacion.list().each {
//            println "p "+proyectos
            def p = it.marcoLogico.proyecto
            if (!proyectos?.id.contains(p.id)) {
                proyectos.add(p)
            }
        }
        if (params.anio) {
            actual = Anio.get(params.anio)
        } else {
            actual = Anio.findByAnio(new Date().format("yyyy"))
        }

        proyectos = proyectos.sort { it.nombre }

        def proyectos2 = Proyecto.findAllByAprobadoPoa('S', [sort: 'nombre'])

        def proyectos3 = Proyecto.findAllByAprobadoPoaAndUnidadAdministradora('S', session.unidad, [sort: 'nombre'])

        def campos = ["numero": ["Número", "string"], "descripcion": ["Descripción", "string"]]
//        println "pro "+proyectos
//        def unidad = UnidadEjecutora.findByCodigo("DPI") // DIRECCIÓN DE PLANIFICACIÓN E INVERSIÓN
//        def personasFirmas = Persona.findAllByUnidad(unidad)
//        def gerentes = Persona.findAllByUnidad(unidad.padre)
        def firmas = firmasService.listaFirmasCombos()

        def total = 0

        def reforma = null, detalles = [], editable = true
        if (params.id) {
            editable = false
            reforma = Reforma.get(params.id)
            detalles = DetalleReforma.findAllByReforma(reforma)
            def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")
            def devuelto = EstadoAval.findByCodigo("D01")
            def estados = [solicitadoSinFirma, devuelto]
            if (estados.contains(reforma.estado)) {
                editable = true
            }
            if (detalles.size() > 0) {
                total = detalles.sum { it.valor }
            }
        }

        return [proyectos      : proyectos3, proyectos2: proyectos3, actual: actual, campos: campos, personas: firmas.directores,
                personasGerente: firmas.gerentes, total: total, editable: editable, reforma: reforma, detalles: detalles, unidad: UnidadEjecutora.get(session.unidad.id)]
    }

    /**
     * Acción que permite realizar una solicitud de reforma de incremento
     */
    def incremento() {
        def proyectos = []
        def actual
        Asignacion.list().each {
//            println "p "+proyectos
            def p = it.marcoLogico.proyecto
            if (!proyectos?.id.contains(p.id)) {
                proyectos.add(p)
            }
        }
        if (params.anio) {
            actual = Anio.get(params.anio)
        } else {
            actual = Anio.findByAnio(new Date().format("yyyy"))
        }

        proyectos = proyectos.sort { it.nombre }

        def proyectos2 = Proyecto.findAllByAprobadoPoa('S', [sort: 'nombre'])

        def proyectos3 = Proyecto.findAllByAprobadoPoaAndUnidadAdministradora('S', session.unidad, [sort: 'nombre'])

        def campos = ["numero": ["Número", "string"], "descripcion": ["Descripción", "string"]]
//        println "pro "+proyectos
//        def unidad = UnidadEjecutora.findByCodigo("DPI") // DIRECCIÓN DE PLANIFICACIÓN E INVERSIÓN
//        def personasFirmas = Persona.findAllByUnidad(unidad)
//        def gerentes = Persona.findAllByUnidad(unidad.padre)
        def firmas = firmasService.listaFirmasCombos()

        def total = 0

        def reforma = null, detalles = [], editable = true
        if (params.id) {
            editable = false
            reforma = Reforma.get(params.id)
            detalles = DetalleReforma.findAllByReforma(reforma)
            def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")
            def devuelto = EstadoAval.findByCodigo("D01")
            def estados = [solicitadoSinFirma, devuelto]
            if (estados.contains(reforma.estado)) {
                editable = true
            }
            if (detalles.size() > 0) {
                total = detalles.sum { it.valor }
            }
        }

        return [proyectos      : proyectos3, proyectos2: proyectos3, actual: actual, campos: campos, personas: firmas.directores,
                personasGerente: firmas.gerentes, total: total, editable: editable, reforma: reforma, detalles: detalles, unidad: UnidadEjecutora.get(session.unidad.id)]
    }

    /**
     * Acción que muestra la lista de todas las reformas, con su estado y una opción para ver el pdf
     */
    def lista() {
        def reformas = Reforma.findAllByTipo('R', [sort: "fecha", order: "desc"])
        return [reformas: reformas]
    }

    /**
     * Acción que muestra la lista de las reformas solicitadas para q un analista de planificación apruebe y pida firmas o niegue
     */
    def pendientes() {
        def estadoSolicitado = EstadoAval.findByCodigo("E01")
        def estadoDevueltoAnalista = EstadoAval.findByCodigo("D02")
        def estados = [estadoSolicitado, estadoDevueltoAnalista]
//        def reformas = Reforma.findAllByTipoAndEstadoInList("R", estados, [sort: "fecha", order: "desc"])

        def reformas = Reforma.withCriteria {
            eq("tipo", "R")
            inList("estado", estados)
            order("fecha", "asc")
        }

//        println params
//        println reformas
//        println reformas.estado
//        println reformas.estado.codigo

        return [reformas: reformas]
    }

    /**
     * Acción llamada con ajax que muestra un historial de reformas solicitadas
     */
    def historial_ajax() {
        def estadoAprobado = EstadoAval.findByCodigo("E02")
        def estadoNegado = EstadoAval.findByCodigo("E03")
        def estadoAprobadoSinFirma = EstadoAval.findByCodigo("EF1")
        def estados = [estadoAprobadoSinFirma, estadoAprobado, estadoNegado]
        def reformas = Reforma.findAllByEstadoInList(estados, [sort: "fecha", order: "desc"])
        return [reformas: reformas]
    }

    /**
     * Acción para que el analista de planificación apruebe y pida firmas o niegue la solicitud
     */
    def procesar() {
        def reforma = Reforma.get(params.id)
        println "init: reforma=${reforma.id} estado reforma id=${reforma.estado.id} cod=${reforma.estado.codigo}"
        if (reforma.estado.codigo == "E01" || reforma.estado.codigo == "D02") {
            def detalles, detalles2 = []
            if (reforma.tipoSolicitud == 'I') {
                detalles2 = DetalleReforma.findAllByReformaAndAsignacionOrigenIsNull(reforma, [sort: "id"])
                detalles = DetalleReforma.findAllByReformaAndAsignacionOrigenIsNotNull(reforma, [sort: "id"])
            } else {
                detalles = DetalleReforma.findAllByReforma(reforma, [sort: "id"])
            }

            def total = 0
            if (detalles.size() > 0) {
                total = detalles.sum { it.valor }
            }
//            def unidad = UnidadEjecutora.findByCodigo("DPI") // DIRECCIÓN DE PLANIFICACIÓN E INVERSIÓN
//            def personasFirmas = Persona.findAllByUnidad(unidad)
//            def gerentes = Persona.findAllByUnidad(unidad.padre)
            def firmas = firmasService.listaFirmasCombos()
            return [reforma: reforma, detalles: detalles, detalles2: detalles2, total: total, personas: firmas.directores, gerentes: firmas.gerentes]
        } else {
            println "redireccionando: reforma=${reforma.id} estado reforma=${reforma.estado.codigo}"
            redirect(action: "pendientes")
        }
    }

    /**
     * Acción llamada con ajax que le permite al analista de planificación seleccionar la asignación de origen para una asignación de destino en una reforma de incremento
     */
    def asignarOrigen_ajax() {
        def reforma = Reforma.get(params.id)
        def detalle = DetalleReforma.get(params.det.toLong())
        def proyectos3 = Proyecto.findAllByAprobadoPoa('S', [sort: 'nombre'])

        return [reforma: reforma, proyectos: proyectos3, detalle: detalle]
    }

    /**
     * Acción llamada con ajax que guarda los pares de asignaciones seleccionados por el asistente de planificación para completar la solicitud de incremento
     */
    def asignarParAsignaciones_ajax() {
        println "\tasignar par asignaciones: " + params
        def detalle = DetalleReforma.get(params.det.toLong())
        def asignacionOrigen = Asignacion.get(params.asg.toLong())
        def monto = (params.mnt.toString().replaceAll(",", "")).toDouble()

        println "\tdetalle ANTES: ${detalle.id}, monto: ${detalle.valor}, saldo: ${detalle.saldo}"
        def nuevoDetalle = new DetalleReforma()
        nuevoDetalle.properties = detalle.properties
        nuevoDetalle.saldo = 0
        nuevoDetalle.valor = monto
        nuevoDetalle.asignacionOrigen = asignacionOrigen
        if (nuevoDetalle.save(flush: true)) {
            detalle.saldo -= monto
            if (!detalle.save(flush: true)) {
                println "error al disminuir saldo de detalle: " + detalle.errors
            }
            println "\tdetalle DESPUES: ${detalle.id}, monto: ${detalle.valor}, saldo: ${detalle.saldo}"
        } else {
            println "error al guardar nuevo detalle: " + nuevoDetalle.errors
            render "ERROR*" + renderErrors(bean: nuevoDetalle)
            return
        }
        render "SUCCESS*Detalle guardado exitosamente"
    }

    /**
     * Acción llamada con ajax que eliminar un par de asignaciones seleccionado por el asistente de planificación para completar la solicitud de incremento
     */
    def eliminarParAsignaciones_ajax() {
        def detalle = DetalleReforma.get(params.id.toLong())
        def detalleOriginal = DetalleReforma.findAllByAsignacionDestinoAndAsignacionOrigenIsNull(detalle.asignacionDestino)
        if (detalleOriginal.size() == 1) {
            def monto = detalle.valor
            try {
                detalleOriginal = detalleOriginal.first()
                detalle.delete(flush: true)
                detalleOriginal.saldo += monto
                if (detalleOriginal.save(flush: true)) {
                    render "SUCCESS*Detalle eliminado exitosamente"
                } else {
                    render "ERROR*" + renderErrors(bean: detalleOriginal)
                }
            } catch (e) {
                println "ERROR al eliminar detalle"
                e.printStackTrace()
                render "ERROR*Ha ocurrido un error grave, no puede eliminar este detalle"
            }
        } else {
            println "Detalle original: ${detalleOriginal}"
            render "ERROR*Ha ocurrido un error grave, no puede eliminar este detalle"
        }
    }

    /**
     * Acción que marca una solicitud como aprobada y a la espera de las firmas de aprobación
     */
    def aprobar() {
        def reforma = Reforma.get(params.id)
        def estadoAprobadoSinFirmas = EstadoAval.findByCodigo("EF1")

        def usu = Persona.get(session.usuario.id)
        def now = new Date()

        def edit = reforma.estado.codigo == "D02"

        reforma.estado = estadoAprobadoSinFirmas
        reforma.fechaRevision = now
        reforma.analista = usu
        reforma.nota = params.observaciones.trim()

        def personaFirma1
        def personaFirma2

        def accion, mensaje

        //E: existente, A: actividad, P: partida, I: incremento
        switch (reforma.tipoSolicitud) {
            case "E":
                accion = "existente"
                mensaje = "Aprobación de reforma a asignaciones existentes"
                break;
            case "A":
                accion = "actividad"
                mensaje = "Aprobación de reforma a nuevas actividades"
                break;
            case "P":
                accion = "partida"
                mensaje = "Aprobación de reforma a nuevas partidas"
                break;
            case "I":
                accion = "incremento"
                mensaje = "Aprobación de reforma de incremento"
                params.each { k, v ->
                    if (k.toString().startsWith("r")) {
                        def parts = v.split("_")
                        if (parts.size() == 2) {
                            def detalle = DetalleReforma.get(parts[0].toLong())
                            def asignacionOrigen = Asignacion.get(parts[1].toLong())
                            detalle.asignacionOrigen = asignacionOrigen
                            detalle.save(flush: true)
                        }
                    }
                }
                break;
            default:
                accion = "existente"
                mensaje = "Aprobación de reforma a asignaciones existentes"
        }

        if (edit) {
            def firma1 = reforma.firma1
            def firma2 = reforma.firma2

            personaFirma1 = firma1.usuario
            personaFirma2 = firma2.usuario

            firma1.estado = "S"
            firma2.estado = "S"

            firma1.save(flush: true)
            firma2.save(flush: true)

        } else {
            personaFirma1 = Persona.get(params.firma1.toLong())
            personaFirma2 = Persona.get(params.firma2.toLong())

            def firma1 = new Firma()
            firma1.usuario = personaFirma1
            firma1.fecha = now
            firma1.accion = "firmarAprobarReforma"
            firma1.controlador = "reforma"
            firma1.idAccion = reforma.id
            firma1.accionVer = accion
            firma1.controladorVer = "reportesReforma"
            firma1.idAccionVer = reforma.id
            firma1.accionNegar = "devolverAprobarReforma"
            firma1.controladorNegar = "reforma"
            firma1.idAccionNegar = reforma.id
            firma1.concepto = "${mensaje} (${reforma.fecha.format('dd-MM-yyyy')}): " + reforma.concepto
            firma1.tipoFirma = "RFRM"
            if (!firma1.save(flush: true)) {
                println "error al crear firma: " + firma1.errors
                render "ERROR*" + renderErrors(bean: firma1)
                return
            }
            reforma.firma1 = firma1

            def firma2 = new Firma()
            firma2.usuario = personaFirma2
            firma2.fecha = now
            firma2.accion = "firmarAprobarReforma"
            firma2.controlador = "reforma"
            firma2.idAccion = reforma.id
            firma2.accionVer = accion
            firma2.controladorVer = "reportesReforma"
            firma2.idAccionVer = reforma.id
            firma2.accionNegar = "devolverAprobarReforma"
            firma2.controladorNegar = "reforma"
            firma2.idAccionNegar = reforma.id
            firma2.concepto = "${mensaje} (${reforma.fecha.format('dd-MM-yyyy')}): " + reforma.concepto
            firma2.tipoFirma = "RFRM"
            if (!firma2.save(flush: true)) {
                println "error al crear firma: " + firma2.errors
                render "ERROR*" + renderErrors(bean: firma2)
                return
            }
            reforma.firma2 = firma2
        }

        def alerta = new Alerta()
        alerta.from = usu
        alerta.persona = personaFirma1
        alerta.fechaEnvio = now
        alerta.mensaje = "${mensaje} (${reforma.fecha.format('dd-MM-yyyy')}): " + reforma.concepto
        alerta.controlador = "firma"
        alerta.accion = "firmasPendientes"
        alerta.id_remoto = 0
        if (!alerta.save(flush: true)) {
            println "error alerta: " + alerta.errors
        }
        def alerta2 = new Alerta()
        alerta2.from = usu
        alerta2.persona = personaFirma2
        alerta2.fechaEnvio = now
        alerta2.mensaje = "${mensaje} (${reforma.fecha.format('dd-MM-yyyy')}): " + reforma.concepto
        alerta2.controlador = "firma"
        alerta2.accion = "firmasPendientes"
        alerta2.id_remoto = 0
        if (!alerta2.save(flush: true)) {
            println "error alerta: " + alerta2.errors
        }

        reforma.save(flush: true)

        render "SUCCESS*Firmas solicitadas exitosamente"
    }

    /**
     * Acción que marca una solicitud como negada
     */
    def negar() {
        def usu = Persona.get(session.usuario.id)
        def now = new Date()

        def reforma = Reforma.get(params.id)
        def estadoNegado = EstadoAval.findByCodigo("E03")
        reforma.estado = estadoNegado
        reforma.fechaRevision = now
        reforma.analista = usu
        reforma.save(flush: true)
        render "SUCCESS*Solicitud negada exitosamente"
    }

    /**
     * no vale
     */
    def existente_old() {
        def proyectos = []
        def actual
        Asignacion.list().each {
//            println "p "+proyectos
            def p = it.marcoLogico.proyecto
            if (!proyectos?.id.contains(p.id)) {
                proyectos.add(p)
            }
        }
        if (params.anio) {
            actual = Anio.get(params.anio)
        } else {
            actual = Anio.findByAnio(new Date().format("yyyy"))
        }

        proyectos = proyectos.sort { it.nombre }

        def proyectos2 = Proyecto.findAllByAprobadoPoa('S', [sort: 'nombre'])

        def campos = ["numero": ["Número", "string"], "descripcion": ["Descripción", "string"]]
//        println "pro "+proyectos
//        def unidad = UnidadEjecutora.findByCodigo("DPI") // DIRECCIÓN DE PLANIFICACIÓN E INVERSIÓN
//        def personasFirmas = Persona.findAllByUnidad(unidad)
//        def gerentes = Persona.findAllByUnidad(unidad.padre)
        def firmas = firmasService.listaFirmasCombos()

        def totalOrigen = 0
        def totalDestino = 0

        return [proyectos      : proyectos, proyectos2: proyectos2, actual: actual, campos: campos, personas: firmas.directores,
                personasGerente: firmas.gerentes, totalOrigen: totalOrigen, totalDestino: totalDestino]
    }

    /**
     * Acción llamada con ajax que elimina un detalle de una reforma existente
     */
    def deleteDetalle_ajax() {
        def detalle = DetalleReforma.get(params.id)
        try {
            detalle.delete(flush: true)
        } catch (e) {
            render "ERROR*Ha ocurrido un error al eliminar el detalle de la reforma"
        }
        render "SUCCESS*Detalle eliminado exitosamente"
    }

    /**
     * Acción llamada con ajax que guarda una solicitud de reforma de asignaciones existentes
     */
    def saveExistente_ajax() {
        def anio = Anio.get(params.anio.toLong())
        def personaRevisa
        def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")

        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def reforma
        if (params.id) {
            reforma = Reforma.get(params.id)
            if (!reforma) {
                reforma = new Reforma()
            }
            personaRevisa = reforma.firmaSolicitud.usuario
        } else {
            reforma = new Reforma()
            personaRevisa = Persona.get(params.firma.toLong())
        }

        reforma.anio = anio
        reforma.persona = usu
        reforma.estado = solicitadoSinFirma
        reforma.concepto = params.concepto.trim()
        reforma.fecha = now
        reforma.tipo = "R"
        reforma.tipoSolicitud = "E"
        if (!reforma.save(flush: true)) {
            println "error al crear la reforma: " + reforma.errors
            render "ERROR*" + renderErrors(bean: reforma)
            return
        }

        if (params.id) {
            def firmaRevisa = reforma.firmaSolicitud
            firmaRevisa.estado = "S"
            firmaRevisa.save(flush: true)
        } else {
            def firmaRevisa = new Firma()
            firmaRevisa.usuario = personaRevisa
            firmaRevisa.fecha = now
            firmaRevisa.accion = "firmarReforma"
            firmaRevisa.controlador = "reforma"
            firmaRevisa.idAccion = reforma.id
            firmaRevisa.accionVer = "existente"
            firmaRevisa.controladorVer = "reportesReforma"
            firmaRevisa.idAccionVer = reforma.id
            firmaRevisa.accionNegar = "devolverReforma"
            firmaRevisa.controladorNegar = "reforma"
            firmaRevisa.idAccionNegar = reforma.id
            firmaRevisa.concepto = "Reforma a asignaciones existentes (${now.format('dd-MM-yyyy')}): " + reforma.concepto
            firmaRevisa.tipoFirma = "RFRM"
            if (!firmaRevisa.save(flush: true)) {
                println "error al crear firma: " + firmaRevisa.errors
                render "ERROR*" + renderErrors(bean: firmaRevisa)
                return
            }
            reforma.firmaSolicitud = firmaRevisa
            reforma.save(flush: true)
        }
        def alerta = new Alerta()
        alerta.from = usu
        alerta.persona = personaRevisa
        alerta.fechaEnvio = now
        alerta.mensaje = "Solicitud de reforma a asignaciones existentes (${now.format('dd-MM-yyyy')}): " + reforma.concepto
        alerta.controlador = "firma"
        alerta.accion = "firmasPendientes"
        alerta.id_remoto = 0
        if (!alerta.save(flush: true)) {
            println "error alerta: " + alerta.errors
        }

        def errores = ""
        params.each { k, v ->
            if (k.toString().startsWith("r")) {
                def parts = v.toString().split("_")
                if (parts.size() >= 3) {
                    def origenId = parts[0].toLong()
                    def destinoId = parts[1].toLong()
                    def monto = parts[2].toString().replaceAll(",", "").toDouble()

                    def asignacionOrigen = Asignacion.get(origenId)
                    def asignacionDestino = Asignacion.get(destinoId)

                    def detalle = new DetalleReforma()
                    detalle.reforma = reforma
                    detalle.asignacionOrigen = asignacionOrigen
                    detalle.asignacionDestino = asignacionDestino
                    detalle.valor = monto
                    if (!detalle.save(flush: true)) {
                        println "error al guardar detalle: " + detalle.errors
                        errores += renderErrors(bean: detalle)
                    }
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Reforma solicitada exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción llamada con ajax que guarda una solicitud de reforma de nueva actividad
     */
    def saveActividad_ajax() {
//        println params
        def detalles = [:]
        params.each { k, v ->
            if (k.toString().startsWith("r")) {
                def parts = k.split("\\[")
                def pos = parts[0]
                def campo = parts[1].split("]")[0]
                if (!detalles[pos]) {
                    detalles[pos] = [:]
                }
                detalles[pos][campo] = v
            }
        }

        def anio = Anio.get(params.anio.toLong())
        def personaRevisa
        def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")

        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def reforma
        if (params.id) {
            reforma = Reforma.get(params.id)
            if (!reforma) {
                reforma = new Reforma()
            }
            personaRevisa = reforma.firmaSolicitud.usuario
        } else {
            reforma = new Reforma()
            personaRevisa = Persona.get(params.firma.toLong())
        }

        reforma.anio = anio
        reforma.persona = usu
        reforma.estado = solicitadoSinFirma
        reforma.concepto = params.concepto.trim()
        reforma.fecha = now
        reforma.tipo = "R"
        reforma.tipoSolicitud = "A"
        if (!reforma.save(flush: true)) {
            println "error al crear la reforma: " + reforma.errors
            render "ERROR*" + renderErrors(bean: reforma)
            return
        }

        if (params.id) {
            def firmaRevisa = reforma.firmaSolicitud
            firmaRevisa.estado = "S"
            firmaRevisa.save(flush: true)
        } else {
            def firmaRevisa = new Firma()
            firmaRevisa.usuario = personaRevisa
            firmaRevisa.fecha = now
            firmaRevisa.accion = "firmarReforma"
            firmaRevisa.controlador = "reforma"
            firmaRevisa.idAccion = reforma.id
            firmaRevisa.accionVer = "actividad"
            firmaRevisa.controladorVer = "reportesReforma"
            firmaRevisa.idAccionVer = reforma.id
            firmaRevisa.accionNegar = "devolverReforma"
            firmaRevisa.controladorNegar = "reforma"
            firmaRevisa.idAccionNegar = reforma.id
            firmaRevisa.concepto = "Reforma a nuevas actividades (${now.format('dd-MM-yyyy')}): " + reforma.concepto
            firmaRevisa.tipoFirma = "RFRM"
            if (!firmaRevisa.save(flush: true)) {
                println "error al crear firma: " + firmaRevisa.errors
                render "ERROR*" + renderErrors(bean: firmaRevisa)
                return
            }
            reforma.firmaSolicitud = firmaRevisa
            reforma.save(flush: true)
        }
        def alerta = new Alerta()
        alerta.from = usu
        alerta.persona = personaRevisa
        alerta.fechaEnvio = now
        alerta.mensaje = "Solicitud de reforma a nuevas actividades (${now.format('dd-MM-yyyy')}): " + reforma.concepto
        alerta.controlador = "firma"
        alerta.accion = "firmasPendientes"
        alerta.id_remoto = 0
        if (!alerta.save(flush: true)) {
            println "error alerta: " + alerta.errors
        }

        def errores = ""
        detalles.each { k, det ->
            def monto = det.monto.replaceAll(",", "").toDouble()

            def asignacionOrigen = Asignacion.get(det.origen.toLong())
            def presupuesto = Presupuesto.get(det.partida.toLong())
            def componente = MarcoLogico.get(det.componente.toLong())

            def detalle = new DetalleReforma()
            detalle.reforma = reforma
            detalle.asignacionOrigen = asignacionOrigen
            detalle.valor = monto
            detalle.presupuesto = presupuesto
            detalle.componente = componente
            detalle.descripcionNuevaActividad = det.actividad.trim()
            detalle.fechaInicioNuevaActividad = new Date().parse("dd-MM-yyyy", det.inicio)
            detalle.fechaFinNuevaActividad = new Date().parse("dd-MM-yyyy", det.fin)
            if (det.categoria) {
                detalle.categoria = Categoria.get(det.categoria.toLong())
            }

            if (!detalle.save(flush: true)) {
                println "error al guardar detalle: " + detalle.errors
                errores += renderErrors(bean: detalle)
            }
        }
        if (errores == "") {
            render "SUCCESS*Reforma solicitada exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción llamada con ajax que guarda una solicitud de reforma de nueva actividad
     */
    def saveIncremento_ajax() {
//        println "Incremento"
//        println params
//        render "ERROR*Aun no"
        def anio = Anio.get(params.anio.toLong())
        def personaRevisa
        def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")

        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def reforma
        if (params.id) {
            reforma = Reforma.get(params.id)
            if (!reforma) {
                reforma = new Reforma()
            }
            personaRevisa = reforma.firmaSolicitud.usuario
        } else {
            reforma = new Reforma()
            personaRevisa = Persona.get(params.firma.toLong())
        }

        reforma.anio = anio
        reforma.persona = usu
        reforma.estado = solicitadoSinFirma
        reforma.concepto = params.concepto.trim()
        reforma.fecha = now
        reforma.tipo = "R"
        reforma.tipoSolicitud = "I"
        if (!reforma.save(flush: true)) {
            println "error al crear la reforma: " + reforma.errors
            render "ERROR*" + renderErrors(bean: reforma)
            return
        }

        if (params.id) {
            def firmaRevisa = reforma.firmaSolicitud
            firmaRevisa.estado = "S"
            firmaRevisa.save(flush: true)
        } else {
            def firmaRevisa = new Firma()
            firmaRevisa.usuario = personaRevisa
            firmaRevisa.fecha = now
            firmaRevisa.accion = "firmarReforma"
            firmaRevisa.controlador = "reforma"
            firmaRevisa.idAccion = reforma.id
            firmaRevisa.accionVer = "incremento"
            firmaRevisa.controladorVer = "reportesReforma"
            firmaRevisa.idAccionVer = reforma.id
            firmaRevisa.accionNegar = "devolverReforma"
            firmaRevisa.controladorNegar = "reforma"
            firmaRevisa.idAccionNegar = reforma.id
            firmaRevisa.concepto = "Reforma de incremento (${now.format('dd-MM-yyyy')}): " + reforma.concepto
            firmaRevisa.tipoFirma = "RFRM"
            if (!firmaRevisa.save(flush: true)) {
                println "error al crear firma: " + firmaRevisa.errors
                render "ERROR*" + renderErrors(bean: firmaRevisa)
                return
            }
            reforma.firmaSolicitud = firmaRevisa
            reforma.save(flush: true)
        }
        def alerta = new Alerta()
        alerta.from = usu
        alerta.persona = personaRevisa
        alerta.fechaEnvio = now
        alerta.mensaje = "Solicitud de reforma de incremento (${now.format('dd-MM-yyyy')}): " + reforma.concepto
        alerta.controlador = "firma"
        alerta.accion = "firmasPendientes"
        alerta.id_remoto = 0
        if (!alerta.save(flush: true)) {
            println "error alerta: " + alerta.errors
        }

        def errores = ""
        params.each { k, v ->
            if (k.toString().startsWith("r")) {
                def parts = v.toString().split("_")
                if (parts.size() >= 2) {
                    def destinoId = parts[0].toLong()
                    def monto = parts[1].toString().replaceAll(",", "").toDouble()

                    def asignacionDestino = Asignacion.get(destinoId)

                    def detalle = new DetalleReforma()
                    detalle.reforma = reforma
                    detalle.asignacionDestino = asignacionDestino
                    detalle.valor = monto
                    detalle.saldo = monto
                    if (!detalle.save(flush: true)) {
                        println "error al guardar detalle: " + detalle.errors
                        errores += renderErrors(bean: detalle)
                    }
                }
            }
        }
        if (errores == "") {
            render "SUCCESS*Reforma solicitada exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción llamada con ajax que guarda una solicitud de reforma de nueva partida
     */
    def savePartida_ajax() {
//        println params
        def detalles = [:]
        params.each { k, v ->
            if (k.toString().startsWith("r")) {
                def parts = k.split("\\[")
                def pos = parts[0]
                def campo = parts[1].split("]")[0]
                if (!detalles[pos]) {
                    detalles[pos] = [:]
                }
                detalles[pos][campo] = v
            }
        }

        def anio = Anio.get(params.anio.toLong())
        def personaRevisa
        def solicitadoSinFirma = EstadoAval.findByCodigo("EF4")

        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def reforma
        if (params.id) {
            reforma = Reforma.get(params.id)
            if (!reforma) {
                reforma = new Reforma()
            }
            personaRevisa = reforma.firmaSolicitud.usuario
        } else {
            reforma = new Reforma()
            personaRevisa = Persona.get(params.firma.toLong())
        }

        reforma.anio = anio
        reforma.persona = usu
        reforma.estado = solicitadoSinFirma
        reforma.concepto = params.concepto.trim()
        reforma.fecha = now
        reforma.tipo = "R"
        reforma.tipoSolicitud = "P"
        if (!reforma.save(flush: true)) {
            println "error al crear la reforma: " + reforma.errors
            render "ERROR*" + renderErrors(bean: reforma)
            return
        }

        if (params.id) {
            def firmaRevisa = reforma.firmaSolicitud
            firmaRevisa.estado = "S"
            firmaRevisa.save(flush: true)
        } else {
            def firmaRevisa = new Firma()
            firmaRevisa.usuario = personaRevisa
            firmaRevisa.fecha = now
            firmaRevisa.accion = "firmarReforma"
            firmaRevisa.controlador = "reforma"
            firmaRevisa.idAccion = reforma.id
            firmaRevisa.accionVer = "partida"
            firmaRevisa.controladorVer = "reportesReforma"
            firmaRevisa.idAccionVer = reforma.id
            firmaRevisa.accionNegar = "devolverReforma"
            firmaRevisa.controladorNegar = "reforma"
            firmaRevisa.idAccionNegar = reforma.id
            firmaRevisa.concepto = "Reforma a nuevas partidas (${now.format('dd-MM-yyyy')}): " + reforma.concepto
            firmaRevisa.tipoFirma = "RFRM"
            if (!firmaRevisa.save(flush: true)) {
                println "error al crear firma: " + firmaRevisa.errors
                render "ERROR*" + renderErrors(bean: firmaRevisa)
                return
            }
            reforma.firmaSolicitud = firmaRevisa
            reforma.save(flush: true)
        }
        def alerta = new Alerta()
        alerta.from = usu
        alerta.persona = personaRevisa
        alerta.fechaEnvio = now
        alerta.mensaje = "Solicitud de reforma a nuevas partidas (${now.format('dd-MM-yyyy')}): " + reforma.concepto
        alerta.controlador = "firma"
        alerta.accion = "firmasPendientes"
        alerta.id_remoto = 0
        if (!alerta.save(flush: true)) {
            println "error alerta: " + alerta.errors
        }
//          [r1:[monto:500.00, origen:322, partida:218, fuente:9], r0:[origen:322, fuente:9, partida:223, monto:150.00]]
        def errores = ""
        detalles.each { k, det ->
            def monto = det.monto.replaceAll(",", "").toDouble()

            def asignacionOrigen = Asignacion.get(det.origen.toLong())
            def presupuesto = Presupuesto.get(det.partida.toLong())
//            def fuente = Fuente.get(det.fuente.toLong())

            def detalle = new DetalleReforma()
            detalle.reforma = reforma
            detalle.asignacionOrigen = asignacionOrigen
            detalle.valor = monto
            detalle.presupuesto = presupuesto
            detalle.fuente = asignacionOrigen.fuente

            if (!detalle.save(flush: true)) {
                println "error al guardar detalle: " + detalle.errors
                errores += renderErrors(bean: detalle)
            }
        }
        if (errores == "") {
            render "SUCCESS*Reforma solicitada exitosamente"
        } else {
            render "ERROR*" + errores
        }
    }

    /**
     * Acción para que un director requirente devuelva una reforma al requirente
     */
    def devolverReforma() {
        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def reforma = Reforma.get(params.id)

        def accion, mensaje
        //E: existente, A: actividad, P: partida, I: incremento
        switch (reforma.tipoSolicitud) {
            case "E":
                accion = "existente"
                mensaje = "Devolución de solicitud de reforma a asignaciones existentes: "
                break;
            case "A":
                accion = "actividad"
                mensaje = "Devolución de solicitud de reforma a nuevas actividades: "
                break;
            case "P":
                accion = "partida"
                mensaje = "Devolución de solicitud de reforma a nuevas partidas: "
                break;
            case "I":
                accion = "incremento"
                mensaje = "Devolución de solicitud de reforma de incremento: "
                break;
            default:
                accion = "existente"
                mensaje = "Devolución de solicitud de reforma a asignaciones existentes: "
        }
        reforma.estado = EstadoAval.findByCodigo("D01") //devuelto
        reforma.save(flush: true)
        def alerta = new Alerta()
        alerta.from = usu
        alerta.persona = reforma.persona
        alerta.fechaEnvio = now
        alerta.mensaje = mensaje + reforma.concepto
        alerta.controlador = "reforma"
        alerta.accion = accion
        alerta.id_remoto = reforma.id
        if (!alerta.save(flush: true)) {
            println "error alerta: " + alerta.errors
        }
        render "OK"
    }

    /**
     * Acción para que un director requirente firme una reforma
     */
    def firmarReforma() {
        def firma = Firma.findByKey(params.key)
        if (!firma) {
            response.sendError(403)
        } else {
            def reforma = Reforma.findByFirmaSolicitud(firma)
            def estadoSolicitado = EstadoAval.findByCodigo("E01")
            reforma.estado = estadoSolicitado
            reforma.save(flush: true)

            def perfilAnalistaPlan = Prfl.findByCodigo("ASPL")
            def analistas = Sesn.findAllByPerfil(perfilAnalistaPlan).usuario
            def now = new Date()
            def usu = Persona.get(session.usuario.id)

            def accion, mensaje
            //E: existente, A: actividad, P: partida, I: incremento
            switch (reforma.tipoSolicitud) {
                case "E":
                    accion = "existente"
                    mensaje = "Solicitud de reforma a asignaciones existentes: "
                    break;
                case "A":
                    accion = "actividad"
                    mensaje = "Solicitud de reforma a nuevas actividades: "
                    break;
                case "P":
                    accion = "partida"
                    mensaje = "Solicitud de reforma a nuevas partidas: "
                    break;
                case "I":
                    accion = "incremento"
                    mensaje = "Solicitud de reforma de incremento: "
                    break;
                default:
                    accion = "existente"
                    mensaje = "Solicitud de reforma a asignaciones existentes: "
            }

            analistas.each { a ->
                def alerta = new Alerta()
                alerta.from = usu
                alerta.persona = a
                alerta.fechaEnvio = now
                alerta.mensaje = mensaje + reforma.concepto
                alerta.controlador = "reforma"
                alerta.accion = "pendientes"
                alerta.id_remoto = reforma.id
                if (!alerta.save(flush: true)) {
                    println "error alerta: " + alerta.errors
                }
            }

            render "ok"
        }
    }

    /**
     * Acción para firmar la aprobación de la reforma
     */
    def firmarAprobarReforma() {
        def firma = Firma.findByKey(params.key)
        if (!firma) {
            response.sendError(403)
        } else {
            def reforma = Reforma.findByFirma1OrFirma2(firma, firma)
            if (reforma.firma1.estado == "F" && reforma.firma2.estado == "F") {
                //busco el ultimo numero asignado para signar el siguiente
                def ultimoNum = Reforma.withCriteria {
                    eq("tipo", "R")
                    projections {
                        max "numero"
                    }
                }

                def num = 1
                if (ultimoNum && ultimoNum.size() == 1) {
                    num = ultimoNum.first() + 1
                }

                def estadoAprobado = EstadoAval.findByCodigo("E02")
                reforma.estado = estadoAprobado
                reforma.numero = num
                reforma.save(flush: true)
                def usu = Persona.get(session.usuario.id)
                def now = new Date()
                def errores = ""
                def detalles
                if (reforma.tipoSolicitud == 'I') {
                    detalles = DetalleReforma.findAllByReformaAndAsignacionOrigenIsNotNull(reforma)
                } else {
                    detalles = DetalleReforma.findAllByReforma(reforma)
                }
                detalles.each { detalle ->
                    def origen = detalle.asignacionOrigen
                    def destino
                    //E: existente, A: actividad, P: partida, I: incremento
                    switch (reforma.tipoSolicitud) {
                        case "E":
                        case "I":
                            destino = detalle.asignacionDestino
                            break;
                        case "A":
                            //busco el ultimo numero asignado para signar el siguiente
                            def ultimoNumAct = MarcoLogico.withCriteria {
                                projections {
                                    max "numero"
                                }
                            }

                            def numAct = 1
                            if (ultimoNumAct && ultimoNumAct.size() == 1) {
                                numAct = ultimoNumAct.first() + 1
                            }

                            def nuevaActividad = new MarcoLogico()
                            nuevaActividad.proyecto = detalle.componente.proyecto
                            nuevaActividad.tipoElemento = TipoElemento.get(3)
                            nuevaActividad.marcoLogico = detalle.componente
                            nuevaActividad.objeto = detalle.descripcionNuevaActividad
                            nuevaActividad.monto = detalle.valor
                            nuevaActividad.estado = 0
                            nuevaActividad.categoria = detalle.categoria
                            nuevaActividad.fechaInicio = detalle.fechaInicioNuevaActividad
                            nuevaActividad.fechaFin = detalle.fechaFinNuevaActividad
                            nuevaActividad.responsable = reforma.persona.unidad
                            nuevaActividad.numero = numAct

                            if (!nuevaActividad.save(flush: true)) {
                                println "error al guardar la actividad (A) " + nuevaActividad.errors
                                errores += renderErrors(bean: nuevaActividad)
                            } else {
                                destino = new Asignacion()
                                destino.anio = reforma.anio
                                destino.fuente = origen.fuente
                                destino.marcoLogico = nuevaActividad
                                destino.presupuesto = detalle.presupuesto
                                destino.planificado = 0
                                destino.unidad = nuevaActividad.responsable
                                destino.priorizado = 0
                                if (!destino.save(flush: true)) {
                                    println "error al guardar la asignacion (RA) " + destino.errors
                                    errores += renderErrors(bean: destino)
                                    destino = null
                                }
                            }
                            break;
                        case "P":
                            destino = new Asignacion()
                            destino.anio = reforma.anio
                            destino.fuente = origen.fuente
                            destino.marcoLogico = origen.marcoLogico
                            destino.presupuesto = detalle.presupuesto
                            destino.planificado = 0
                            destino.unidad = origen.marcoLogico.responsable
                            destino.priorizado = 0
                            if (!destino.save(flush: true)) {
                                println "error al guardar la asignacion (P) " + destino.errors
                                errores += renderErrors(bean: destino)
                                destino = null
                            }
                            break;
                    }
                    if (origen && destino) {
                        def modificacion = new ModificacionAsignacion()
                        modificacion.usuario = usu
                        modificacion.desde = origen
                        modificacion.recibe = destino
                        modificacion.fecha = now
                        modificacion.valor = detalle.valor
                        modificacion.estado = 'A'
                        modificacion.detalleReforma = detalle
                        modificacion.originalOrigen = origen.priorizado
                        modificacion.originalDestino = destino.priorizado
                        if (!modificacion.save(flush: true)) {
                            println "error save modificacion: " + modificacion.errors
                            errores += renderErrors(bean: modificacion)
                        } else {
                            origen.priorizado -= detalle.valor
                            destino.priorizado += detalle.valor
                            if (!origen.save(flush: true)) {
                                println "error save origen: " + origen.errors
                                errores += renderErrors(bean: origen)
                            }
                            if (!destino.save(flush: true)) {
                                println "error save destino: " + destino.errors
                                errores += renderErrors(bean: destino)
                            }
                        }
                    }
                }
            }
            render "ok"
        }
    }

    /**
     * Acción para devolver la solicitud de reforma al analista de planificación
     */
    def devolverAprobarReforma() {
        def now = new Date()
        def usu = Persona.get(session.usuario.id)

        def reforma = Reforma.get(params.id)
        reforma.estado = EstadoAval.findByCodigo("D02") //devuelto al analista
        reforma.save(flush: true)
        /* TODO: a quien debe mandar la alerta? */

        def perfilAnalistaPlan = Prfl.findByCodigo("ASPL")
        def analistas = Sesn.findAllByPerfil(perfilAnalistaPlan).usuario

        def accion, mensaje
        //E: existente, A: actividad, P: partida, I: incremento
        switch (reforma.tipoSolicitud) {
            case "E":
                accion = "existente"
                mensaje = "Devolución de solicitud de reforma a asignaciones existentes: "
                break;
            case "A":
                accion = "actividad"
                mensaje = "Devolución de solicitud de reforma a nuevas actividades: "
                break;
            case "P":
                accion = "partida"
                mensaje = "Devolución de solicitud de reforma a nuevas partidas: "
                break;
            case "I":
                accion = "incremento"
                mensaje = "Devolución de solicitud de reforma de incremento: "
                break;
            default:
                accion = "existente"
                mensaje = "Devolución de solicitud de reforma a asignaciones existentes: "
        }

        analistas.each { a ->
            def alerta = new Alerta()
            alerta.from = usu
            alerta.persona = a
            alerta.fechaEnvio = now
            alerta.mensaje = mensaje + reforma.concepto
            alerta.controlador = "reforma"
            alerta.accion = accion
            alerta.id_remoto = reforma.id
            if (!alerta.save(flush: true)) {
                println "error alerta: " + alerta.errors
            }
        }
        render "OK"
    }

}
