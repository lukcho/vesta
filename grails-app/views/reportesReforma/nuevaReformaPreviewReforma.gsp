
<%@ page import="vesta.proyectos.MarcoLogico" contentType="text/html;charset=UTF-8" %>
<%@ page import="vesta.parametros.UnidadEjecutora; vesta.seguridad.FirmasService" %>
<%
    def firmasService = grailsApplication.classLoader.loadClass('vesta.seguridad.FirmasService').newInstance()
%>

<html>
<head>
    <meta name="layout" content="reportesReformaSolicitud"/>
    <title>
        ${reforma.tituloReforma}
    </title>
</head>

<body>

<rep:headerFooter title="${reforma.tituloReforma.toUpperCase()}"
                  form="GPE-DPI-003"
                  unidad="${unidades.unidad}"
                  numero="${reforma.numeroReforma}" estilo="right"/>


<div style="margin-left: 10px;">
    <div>
        <ol>
            <li>
                <strong>Unidad responsable (Gerencia - Dirección):</strong>
                <g:if test="${unidades}">
                    <g:if test="${unidades.gerencia.id != unidades.unidad.id}">
                        ${unidades.gerencia} -
                    </g:if>
                    ${unidades.unidad}
                </g:if>
                <g:else>
                    ${reforma.persona.unidad} (No está completo el código!)
                </g:else>
            </li>
            <li>
                <strong>Matriz de la ${reforma.tituloReforma.toLowerCase()}:</strong>


                <g:set var="totalOrigen" value="${0}"/>
                <g:set var="disminucion" value="${0}"/>
                <g:set var="incremento" value="${0}"/>
                <g:set var="montoFinal" value="${0}"/>

                <table class="table table-hover table-condensed table-hover table-bordered">
                    <thead>
                    <tr>
                        <th>Año</th>
                        <th>Fuente</th>
                        <th>Proyecto</th>
                        <th>Componente</th>
                        <th>Actividad</th>
                        <th>Partida</th>
                        <th>Responsable</th>
                        <th>Valor inicial<br/>USD</th>
                        <th>Disminución<br/>USD</th>
                        <th>Aumento<br/>USD</th>
                        <th>Valor final<br/>USD</th>
                    </tr>
                    </thead>
                    <tbody class="tb">
                    <g:each in="${detallesReforma}" var="detallesNuevos">
                        <g:if test="${detallesNuevos?.tipoReforma?.codigo == 'O'}">
                            <tr>
                                <td style="width: 4%">${detallesNuevos?.anio}</td>
                                <td style="width:4%">${detallesNuevos?.fuente?.codigo}</td>
                                <td style="width: 15%">${detallesNuevos?.componente?.proyecto?.nombre}</td>
                                <td style="width: 12%">${detallesNuevos?.componente?.objeto}</td>
                                <td style="width: 15%">${detallesNuevos?.asignacionOrigen?.marcoLogico?.numero} - ${detallesNuevos?.asignacionOrigen?.marcoLogico?.objeto}</td>
                                <td style="width: 6%; text-align: center">${detallesNuevos?.asignacionOrigen?.presupuesto?.numero}</td>
                                %{--<td style='width:8%; text-align: center'>${detallesNuevos?.responsable?.codigo}</td>--}%
                                <td style='width:8%; text-align: center'>${firmasService.requirentes(vesta.parametros.UnidadEjecutora.findByCodigo(detallesNuevos?.responsable?.codigo))?.codigo}</td>

                                <td style="width: 8%; text-align: right"><g:formatNumber number="${detallesNuevos?.valorOrigenInicial}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                                <td style="width: 9%; text-align: right;"><g:formatNumber number="${detallesNuevos?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                                <td style="width: 9%; text-align: center ">${' --- '}</td>
                                <td style="width: 8%; text-align: right"><g:formatNumber number="${detallesNuevos?.valorOrigenInicial - detallesNuevos?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                            </tr>
                            <g:set var="disminucion" value="${disminucion += detallesNuevos?.valor}"/>
                            <g:set var="montoFinal" value="${montoFinal += (detallesNuevos?.valorOrigenInicial - detallesNuevos?.valor)}"/>
                        </g:if>
                        <g:if test="${detallesNuevos?.tipoReforma?.codigo == 'E' || detallesNuevos?.tipoReforma?.codigo == 'P' }">
                            <tr>
                                <td style="width: 4%">${detallesNuevos?.anio}</td>
                                <td style="width:4%">${detallesNuevos?.fuente?.codigo}</td>
                                <td style="width: 15%">${detallesNuevos?.componente?.proyecto?.nombre}</td>
                                <g:if test="${detallesNuevos?.tipoReforma?.codigo == 'P'}">
                                    <td style="width: 12%">${detallesNuevos?.componente?.marcoLogico?.objeto}</td>
                                    <td style="width: 15%">${detallesNuevos?.componente?.numero} - ${detallesNuevos?.componente?.objeto}</td>
                                </g:if>
                                <g:else>
                                    <td style="width: 12%">${detallesNuevos?.componente?.objeto}</td>
                                    <td style="width: 15%">${detallesNuevos?.asignacionOrigen?.marcoLogico?.numero} - ${detallesNuevos?.asignacionOrigen?.marcoLogico?.objeto}</td>
                                </g:else>
                                <g:if test="${detallesNuevos?.tipoReforma?.codigo == 'P'}">
                                    <td style='width:6%; text-align: center'>${detallesNuevos?.presupuesto?.numero}</td>
                                </g:if>
                                <g:else>
                                    <td style='width:6%; text-align: center'>${detallesNuevos?.asignacionOrigen?.presupuesto?.numero}</td>
                                </g:else>
                                %{--<td style='width:8%; text-align: center'>${detallesNuevos?.responsable?.codigo}</td>--}%
                                <td style='width:8%; text-align: center'>${firmasService.requirentes(vesta.parametros.UnidadEjecutora.findByCodigo(detallesNuevos?.responsable?.codigo))?.codigo}</td>

                                %{--<td style='width:8%; text-align: center'>${vesta.proyectos.MarcoLogico.findByMarcoLogico(detallesNuevos.componente)?.responsable?.codigo}</td>--}%
                                <td style='width:8%; text-align: right'><g:formatNumber number="${detallesNuevos?.valorDestinoInicial}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                                <td style='width:9%; text-align: center'>${' --- '}</td>
                                <td style='width:9%; text-align: right'><g:formatNumber number="${detallesNuevos?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                                <td style='width:8%; text-align: right'><g:formatNumber number="${detallesNuevos?.valorDestinoInicial + detallesNuevos?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                            </tr>
                            <g:set var="incremento" value="${incremento += detallesNuevos?.valor}"/>
                            <g:set var="montoFinal" value="${montoFinal += (detallesNuevos?.valorDestinoInicial + detallesNuevos?.valor)}"/>
                        </g:if>
                        <g:if test="${detallesNuevos?.tipoReforma?.codigo == 'A'}" >
                            <tr>
                                <g:set var="nuevaActv" value="${vesta.proyectos.MarcoLogico.findByObjeto(detallesNuevos?.descripcionNuevaActividad)?.numero}"/>
                                <g:if test="${nuevaActv}">
                                    <g:set var="nuevaActvStr" value="${nuevaActv} - "/>
                                </g:if>
                                <g:else>
                                    <g:set var="nuevaActvStr" value="S/N - "/>
                                </g:else>
                                <td style="width: 4%">${detallesNuevos?.anio}</td>
                                <td style="width:4%">${detallesNuevos?.fuente?.codigo}</td>
                                <td style='width:15%'>${detallesNuevos?.componente?.proyecto?.nombre}</td>
                                <td style='width:12%'>${detallesNuevos?.componente?.objeto}</td>
                                <td style='width:15%'>${nuevaActvStr}${detallesNuevos?.descripcionNuevaActividad}</td>
                                <td style='width:6%; text-align: center'>${detallesNuevos?.presupuesto?.numero}</td>
                                %{--<td style='width:8%; text-align: center'>${detallesNuevos?.responsable?.codigo}</td>--}%
                                <td style='width:8%; text-align: center'>${firmasService.requirentes(vesta.parametros.UnidadEjecutora.findByCodigo(detallesNuevos?.responsable?.codigo))?.codigo}</td>
                                <td style='width:8%; text-align: center'>${' --- '}</td>
                                <td style='width:9%; text-align: center'>${' --- '}</td>
                                <td style='width:9%; text-align: right'><g:formatNumber number="${detallesNuevos?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                                <td style='width:8%; text-align: right'><g:formatNumber number="${detallesNuevos?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                            </tr>
                            <g:set var="incremento" value="${incremento += detallesNuevos?.valor}"/>
                            <g:set var="montoFinal" value="${montoFinal += detallesNuevos?.valor}"/>
                        </g:if>
                        <g:set var="totalOrigen" value="${totalOrigen += (detallesNuevos?.valorDestinoInicial + detallesNuevos?.valorOrigenInicial)}"/>
                    </g:each>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th colspan="7" class="formato" style="text-align: center">TOTAL: </th>
                        <th style="width: 8%; text-align: right" class="formato"><g:formatNumber number="${totalOrigen}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                        <th style="width: 9%; text-align: right" class="formato"><g:formatNumber number="${disminucion}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                        <th style="width: 9%; text-align: right" class="formato"><g:formatNumber number="${incremento}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                        <th style="width: 8%; text-align: right" class="formato"><g:formatNumber number="${montoFinal}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                    </tr>
                    </tfoot>
                </table>




            </li>
            <li class="no-break" style="margin-top: 15px">
                <strong>Observación:</strong>

                <div class="justificacion">
                    ${reforma.nota.decodeHTML()}
                </div>
            </li>
        </ol>

        <div>
            <strong>Elaborado por:</strong> ${reforma.analista ? reforma.analista.sigla : reforma.persona.sigla}
        </div>

        <div class="fright">
            <g:if test="${reforma?.firma1?.id > reforma?.firma2?.id }">
                <strong>FECHA:</strong> ${reforma.firma1?.fecha?.format("dd-MM-yyyy")}
            </g:if>
            <g:else>
                <strong>FECHA:</strong> ${reforma.firma2?.fecha?.format("dd-MM-yyyy")}
            </g:else>

        </div>
    </div>

    <div class="no-break">
        <table width="100%" style="margin-top: 0.5cm; border: none" border="none">
            <tr>
                <g:if test="${reforma.firma1?.estado == 'F' && reforma.firma2?.estado == 'F'}">
                    <td width="25%" style="text-align: center; border: none"><b>Revisado por:</b></td>
                    <td width="25%" style="border: none"></td>
                    <td width="25%" style="text-align: center; border: none"><b>Aprobado por:</b></td>
                    <td width="25%" style="border: none"></td>
                </g:if>

                <g:if test="${reforma.firma1?.estado == 'F' && reforma.firma2?.estado != 'F'}">
                    <td width="25%" style="text-align: center; border: none"><b>Aprobado por:</b></td>
                    <td width="25%" style="border: none"></td>
                    <td width="25%" style="border: none"></td>
                    <td width="25%" style="border: none"></td>
                </g:if>
                <g:if test="${reforma.firma2?.estado == 'F' && reforma.firma1?.estado != 'F'}">
                    <td width="25%" style="border: none"></td>
                    <td width="25%" style="border: none"></td>
                    <td width="25%" style="text-align: center; border: none"><b>Aprobado por:</b></td>
                    <td width="25%" style="border: none"></td>
                </g:if>
            </tr>
        </table>

        <table width="100%" style="border: none" border="none">
            <tr>
                <td width="50%" style=" text-align: center;border: none">
                    <g:if test="${reforma?.firma1?.estado == 'F'}">
                        <g:if test="${resource(dir: 'firmas', file: reforma.firma1.path)}">
                            <img src="${resource(dir: 'firmas', file: reforma.firma1.path)}" style="width: 150px;"/><br/>

                            <div style="width: 150px; border-bottom: solid 1px; margin-left: 170px"></div>
                            <b style="text-align: center">
                                ${reforma.firma1.usuario.nombre} ${reforma.firma1.usuario.apellido}<br/>
                            </b>
                            <b style="text-align: center;">
                                %{--${reforma.firma1.usuario.cargoPersonal?.toString()?.toUpperCase()}<br/>--}%
                                ${reforma.firma1.usuario.cargo?.toString()?.toUpperCase()}<br/>
                            </b>
                        </g:if>
                        <g:else>
                            <img src="${resource(dir: 'firmas', file: reforma.firma1.path)}" style="width: 150px;"/><br/>

                            <div style="width: 150px; border-bottom: solid 1px; margin-left: 170px; margin-top: 150px"></div>
                            <b style="text-align: center">
                                ${reforma.firma1.usuario.nombre} ${reforma.firma1.usuario.apellido}<br/>
                            </b>
                            <b style="text-align: center;">
                                %{--${reforma.firma1.usuario.cargoPersonal?.toString()?.toUpperCase()}<br/>--}%
                                ${reforma.firma1.usuario.cargo?.toString()?.toUpperCase()}<br/>
                            </b>
                        </g:else>

                    </g:if>
                </td>
                <td width="50%" style=" text-align: center;;border: none">
                    <g:if test="${reforma?.firma2?.estado == 'F'}">
                        <g:if test="${resource(dir: 'firmas', file: reforma.firma2.path)}">
                            <img src="${resource(dir: 'firmas', file: reforma.firma2.path)}" style="width: 150px;"/><br/>

                            <div style="width: 150px; border-bottom: solid 1px; margin-left: 170px;"></div>
                            <b style="text-align: center;">
                                ${reforma.firma2.usuario.nombre} ${reforma.firma2.usuario.apellido}<br/>
                            </b>
                            <b style="text-align: center;">
                                %{--${reforma.firma2.usuario.cargoPersonal?.toString()?.toUpperCase()}<br/>--}%
                                ${reforma.firma2.usuario.cargo?.toString()?.toUpperCase()}<br/>
                            </b>

                        </g:if>
                        <g:else>
                            <img src="${resource(dir: 'firmas', file: reforma.firma2.path)}" style="width: 150px;"/><br/>

                            <div style="width: 150px; border-bottom: solid 1px; margin-left: 170px; margin-top: 150px"></div>
                            <b style="text-align: center;">
                                ${reforma.firma2.usuario.nombre} ${reforma.firma2.usuario.apellido}<br/>
                            </b>
                            <b style="text-align: center;">
                                ${reforma.firma2.usuario.cargo?.toString()?.toUpperCase()}<br/>
                                %{--${reforma.firma2.usuario.cargoPersonal?.toString()?.toUpperCase()}<br/>--}%
                            </b>
                        </g:else>

                    </g:if>
                </td>
            </tr>
        </table>
    </div>

</div>


</body>
</html>