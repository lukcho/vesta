<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 26/06/15
  Time: 03:48 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Solicitud aval corriente</title>
        <rep:estilos orientacion="p" pagTitle="Aval de POA corriente"/>
        <style type="text/css">
        .table {
            width           : 100%;
            border-collapse : collapse;
            border          : solid 1px #555;
            margin-top      : 10px;
        }

        .table td, .table th {
            border : solid 1px #555;
        }

        .tbl-small {
            margin : 5px;
            border : solid 1px #AAA;
        }

        .tbl-small td, .tbl-small th {
            border : solid 1px #AAA;
        }
        </style>
    </head>

    <body>
        <g:set var="anio" value="${proceso.fechaSolicitud.format("yyyy")}"/>

        <rep:headerFooter title="Aval de POA corriente" unidad="${proceso.fechaSolicitud.format('yyyy')}-${proceso.usuario.unidad?.codigo}"
                          numero="${proceso.numeroAval.toString().padLeft(3, '0')}" estilo="right"/>

        <p>
            Con solicitud de aval de POA ${anio}-${proceso.usuario.unidad.sigla}
            Nro. ${proceso.numeroAval.toString().padLeft(3, '0')}, de fecha ${proceso.fechaSolicitud.format("dd-MM-yyyy")},
            la ${proceso.usuario.unidad.nombre} solicita emitir el aval de POA para realizar el proceso "${proceso.nombreProceso}",
            por un monto total de USD <g:formatNumber number="${proceso.monto}" type="currency" currencySymbol="USD "/>
            (${transf.toLowerCase()}), con base en cual informo lo siguiente:
        </p>

        <p>
            Luego de revisar el Plan Operativo Anual ${anio}, la Gerencia de Planificación Estratégica emite el aval a la actividad conforme el siguiente detalle:
        </p>

        <table class="table table-bordered table-condensed">
            <tr>
                <th style="width: 200px">
                    UNIDAD REQUIRENTE
                </th>
                <td>${proceso.usuario.unidad}</td>
            </tr>
            <tr>
                <th>
                    NOMBRE PROCESO
                </th>
                <td>
                    ${proceso.nombreProceso}
                </td>
            </tr>
            <tr>
                <th>
                    JUSTIFICACIÓN
                </th>
                <td>
                    ${proceso.concepto}
                </td>
            </tr>
            <tr>
                <th>
                    FECHA DE INICIO
                </th>
                <td>
                    ${proceso.fechaInicioProceso.format("dd-MM-yyyy")}
                </td>
            </tr>
            <tr>
                <th>
                    FECHA DE FIN
                </th>
                <td>
                    ${proceso.fechaFinProceso.format("dd-MM-yyyy")}
                </td>
            </tr>
            <tr>
                <th>
                    MONTO TOTAL SOLICITADO
                </th>
                <td>
                    <g:formatNumber number="${proceso.monto}" type="currency" currencySymbol="USD "/>
                </td>
            </tr>
        </table>

        <g:each in="${detalles}" var="d">
            <g:set var="det" value="${d.value}"/>
            <table class="table table-bordered table-condensed">
                <tr>
                    <td style="width:200px; font-weight: bold">OBJETIVO GASTO CORRIENTE</td>
                    <td>${det.tarea.actividad.macroActividad.objetivoGastoCorriente.descripcion}</td>
                </tr>
                <tr>
                    <td style="font-weight: bold">MACROACTIVIDAD</td>
                    <td>${det.tarea.actividad.macroActividad.descripcion}</td>
                </tr>
                <tr>
                    <td style="font-weight: bold">ACTIVIDAD</td>
                    <td>${det.tarea.actividad.descripcion}</td>
                </tr>
                <tr>
                    <td style="font-weight: bold">TAREA</td>
                    <td>${det.tarea.descripcion}</td>
                </tr>
                <tr>
                    <td style="font-weight: bold">ASIGNACIONES</td>
                    <td>
                        <table class="table table-bordered table-condensed tbl-small" style="width: auto">
                            <thead>
                                <tr>
                                    <th>Asignación</th>
                                    <th>Fuente</th>
                                    <th>Monto</th>
                                </tr>
                            </thead>
                            <g:set var="total" value="${0}"/>
                            <tbody>
                                <g:each in="${det.asignaciones}" var="a">
                                    <g:set var="total" value="${total + a.monto}"/>
                                    <tr>
                                        <td>${a.asg.presupuesto}</td>
                                        <td>${a.asg.fuente}</td>
                                        <td class="text-right"><g:formatNumber number="${a.monto}" type="currency" currencySymbol=""/></td>
                                    </tr>
                                </g:each>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="2">TOTAL</th>
                                    <td class="text-right"><g:formatNumber number="${total}" type="currency" currencySymbol=""/></td>
                                </tr>
                            </tfoot>
                        </table>
                    </td>
                </tr>
            </table>
        </g:each>

        <div class="texto">
            <p>
                <strong>Nota Técnica:</strong> ${proceso.notaTecnica}
            </p>
        </div>


        <div class="observaciones">
            <span class="ttl">OBSERVACIONES:</span>
            ${proceso.observacionesPdf}
        </div>

        <p>
            Es importante señalar que la Gerencia Administrativa Financiera en el marco de sus competencias verificará la disponibilidad presupuestaria.
        </p>

        <p>
            <strong>Elaborado por:</strong> ${proceso.analista ?
                (proceso.analista.sigla ?: proceso.analista.nombre + ' ' + proceso.analista.apellido) :
                (proceso.usuario.sigla ?: proceso.usuario.nombre + ' ' + proceso.usuario.apellido)
        }
        </p>

        <p style="float: right">
            <strong>FECHA:</strong> ${proceso.fechaSolicitud.format("dd-MM-yyyy")}
        </p>

        <div style="text-align: justify;float: left;font-size: 10pt;width: 100%">
            <g:if test="${proceso.firma1}">
                <table width="100%" style="margin-top: 1.5cm; border: none" border="none">
                    <tr>
                        <g:if test="${proceso.firma1?.estado == 'F' && proceso.firma2?.estado == 'F'}">
                            <td width="25%" style="text-align: center; border: none"><b>Revisado por:</b></td>
                            <td width="25%" style="border: none"></td>
                            <td width="25%" style="text-align: center; border: none"><b>Aprobado por:</b></td>
                            <td width="25%" style="border: none"></td>
                        </g:if>

                        <g:if test="${proceso.firma1?.estado == 'F' && proceso.firma2?.estado != 'F'}">
                            <td width="25%" style="text-align: center; border: none"><b>Revisado por:</b></td>
                            <td width="25%" style="border: none"></td>
                            <td width="25%" style="border: none"></td>
                            <td width="25%" style="border: none"></td>
                        </g:if>
                        <g:if test="${proceso.firma2?.estado == 'F' && proceso.firma1?.estado != 'F'}">
                            <td width="25%" style="border: none"></td>
                            <td width="25%" style="border: none"></td>
                            <td width="25%" style="text-align: center; border: none"><b>Aprobado por:</b></td>
                            <td width="25%" style="border: none"></td>
                        </g:if>
                    </tr>
                </table>


                <table width="100%" style="margin-top: 1.5cm; border: none" border="none">
                    <tr>
                        <td width="50%" style=" text-align: center;border: none">
                            <g:if test="${proceso.firma1?.estado == 'F'}">
                                <img src="${resource(dir: 'firmas', file: proceso.firma1.path)}" style="width: 150px;"/><br/>
                                ${proceso.firma1.usuario.nombre} ${proceso.firma1.usuario.apellido}<br/>
                                <b>${proceso.firma1.usuario.cargoPersonal}<br/></b>
                            </g:if>
                        </td>
                        <td width="50%" style=" text-align: center;;border: none">
                            <g:if test="${proceso.firma2?.estado == 'F'}">
                                <img src="${resource(dir: 'firmas', file: proceso.firma2.path)}" style="width: 150px"/><br/>
                                ${proceso.firma2.usuario.nombre} ${proceso.firma2.usuario.apellido}<br/>
                                <b>${proceso.firma2.usuario.cargoPersonal}<br/></b>
                            </g:if>
                        </td>
                    </tr>
                </table>
            </g:if>
        </div>

    </body>
</html>