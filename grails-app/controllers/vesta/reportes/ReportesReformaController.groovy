package vesta.reportes

import vesta.modificaciones.DetalleReforma
import vesta.modificaciones.ModificacionesPoaController
import vesta.modificaciones.Reforma
import vesta.parametros.poaPac.Anio
import vesta.proyectos.ModificacionAsignacion

class ReportesReformaController {

    def index() {}

    def existente (){

        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)
        def total = 0
        if (detalles.size() > 0) {
            total = detalles.sum { it.valor }
        }
        def anio = Anio.findByAnio(new Date().format("yyyy"))

        return [reforma: reforma, anio: anio, detalles: detalles,total: total]

    }

    def actividad () {

        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)
        def total = 0
        if (detalles.size() > 0) {
            total = detalles.sum { it.valor }
        }
        def anio = Anio.findByAnio(new Date().format("yyyy"))

        return [reforma: reforma, anio: anio, detalles: detalles,total: total]
    }

    def partida () {

        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)
        def total = 0
        if (detalles.size() > 0) {
            total = detalles.sum { it.valor }
        }
        def anio = Anio.findByAnio(new Date().format("yyyy"))

        return [reforma: reforma, anio: anio, detalles: detalles,total: total]

    }

    def incremento () {
        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReformaAndAsignacionOrigenIsNull(reforma)
        def detalles2 = DetalleReforma.findAllByReformaAndAsignacionOrigenIsNotNull(reforma)



        def total = 0
        if (detalles.size() > 0) {
            total = detalles.sum { it.valor }
        }
        def anio = Anio.findByAnio(new Date().format("yyyy"))

        return [reforma: reforma, anio: anio, detalles: detalles,total: total, detalles2: detalles2]

    }

    def existenteReforma () {

        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)

        println("detalles " + detalles)
        def modificaciones = ModificacionAsignacion.findAllByDetalleReformaInList(detalles)
        println("modificaciones " + modificaciones)

        def anio = Anio.findByAnio(new Date().format("yyyy"))

//        def total = 0
//        if (detalles.size() > 0) {
//            total = detalles.sum { it.valor }
//        }
//        def anio = Anio.findByAnio(new Date().format("yyyy"))


        return [reforma: reforma, anio: anio, modificaciones: modificaciones]
//        return [reforma: reforma, anio: anio, detalles: detalles]

    }

    def actividadReforma () {

        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)
        def total = 0
        if (detalles.size() > 0) {
            total = detalles.sum { it.valor }
        }
        def anio = Anio.findByAnio(new Date().format("yyyy"))

        return [reforma: reforma, anio: anio, detalles: detalles,total: total]

    }

    def partidaReforma () {
        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)
        def total = 0
        if (detalles.size() > 0) {
            total = detalles.sum { it.valor }
        }
        def anio = Anio.findByAnio(new Date().format("yyyy"))

        return [reforma: reforma, anio: anio, detalles: detalles,total: total]

    }


    def incrementoReforma () {

        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)

        def modificaciones = ModificacionAsignacion.findAllByDetalleReformaInList(detalles)

        def anio = Anio.findByAnio(new Date().format("yyyy"))

        return [reforma: reforma, anio: anio, modificaciones: modificaciones]

    }

}
