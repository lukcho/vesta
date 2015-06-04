<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 14/04/15
  Time: 10:50 AM
--%>

<%@ page import="vesta.poa.ProgramacionAsignacion; vesta.poa.Asignacion; vesta.parametros.TipoElemento; vesta.proyectos.MarcoLogico; vesta.parametros.poaPac.Mes" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>POA por Unidad Ejecutora</title>

        <rep:estilos orientacion="l" pagTitle="POA: Resumen por Unidad Ejecutora ${anio.anio}"/>

        <style type="text/css">
        .table {
            margin-top      : 0.5cm;
            width           : 100%;
            border-collapse : collapse;
        }

        .table, .table td, .table th {
            border : solid 1px #444;
        }

        .table td, .table th {
            padding : 3px;
        }

        .text-right {
            text-align : right;
        }

        h1.break {
            page-break-before : always;
        }

        small {
            font-size : 70%;
            color     : #777;
        }

        .table th {
            background     : #326090;
            color          : #fff;
            text-align     : center;
            text-transform : uppercase;
        }

        .actual {
            background : #c7daed;
        }

        .info {
            background : #6fa9ed;
        }

        .text-right {
            text-align : right !important;
        }

        .text-center {
            text-align : center;
        }
        </style>

    </head>

    <body>
        <rep:headerFooter title="PLANIFICACIÓN OPERATIVA ANUAL - POA AÑO ${anio.anio}" subtitulo="RESUMEN POR UNIDAD EJECUTORA"/>

    <p>
        Fecha del reporte: ${new java.util.Date().format("dd-MM-yyyy HH:mm")}
    </p>
        <table class="table table-bordered table-hover table-condensed table-bordered">
            <thead>
                <tr>
                    <th>NÚMERO</th>
                    <th>DESCRIPCIÓN</th>
                    <th>SIGLAS</th>
                    <th>ARRASTRE AÑO ${anio.anio.toInteger() - 1}</th>
                    <th>REQUERIMIENTO AÑO ${anio.anio}</th>
                    <th>PRESUPUESTO CODIFICADO AÑO ${anio.anio}</th>
                    <g:each in="${anios}" var="a">
                        <th>AÑO${a}</th>
                    </g:each>
                    <th>TOTAL PLURIANUAL</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${data}" var="v" status="i">
                    <tr>
                        <td>${i + 1}</td>
                        <td>${v.unidad}</td>
                        <td class="text-center">${v.unidad.codigo}</td>
                        <td class="text-right actual">
                            <g:if test="${v.valores["" + (anio.anio.toInteger() - 1)] > 0}">
                                <g:formatNumber number="${v.valores["" + (anio.anio.toInteger() - 1)]}" type="currency" currencySymbol=""/>
                            </g:if>
                            <g:else>
                                -
                            </g:else>
                        </td>
                        <td class="text-right actual">
                            <g:if test="${v.valores[anio.anio] > 0}">
                                <g:formatNumber number="${v.valores[anio.anio]}" type="currency" currencySymbol=""/>
                            </g:if>
                            <g:else>
                                -
                            </g:else>
                        </td>
                        <td class="text-right info">
                            <g:if test="${v.valores["T" + anio.anio] > 0}">
                                <g:formatNumber number="${v.valores["T" + anio.anio]}" type="currency" currencySymbol=""/>
                            </g:if>
                            <g:else>
                                -
                            </g:else>
                        </td>
                        <g:each in="${anios}" var="a">
                            <td class="text-right">
                                <g:if test="${v.valores[a] > 0}">
                                    <g:formatNumber number="${v.valores[a] ?: 0}" type="currency" currencySymbol=""/>
                                </g:if>
                                <g:else>
                                    -
                                </g:else>
                            </td>
                        </g:each>
                        <td class="text-right">
                            <g:formatNumber number="${v.valores['T']}" type="currency" currencySymbol=""/>
                        </td>
                    </tr>
                </g:each>
            </tbody>
            <tfoot>
                <tr>
                    <th class="text-right" colspan="3">TOTAL</th>
                    <th class="text-right"><g:formatNumber number="${totales['2014']}" type="currency" currencySymbol=""/></th>
                    <th class="text-right"><g:formatNumber number="${totales['2015']}" type="currency" currencySymbol=""/></th>
                    <th class="text-right"><g:formatNumber number="${totales['T2015']}" type="currency" currencySymbol=""/></th>
                    <g:each in="${anios}" var="a">
                        <th class="text-right"><g:formatNumber number="${totales[a] ?: 0}" type="currency" currencySymbol=""/></th>
                    </g:each>
                    <th class="text-right"><g:formatNumber number="${totales['T']}" type="currency" currencySymbol=""/></th>
                </tr>
            </tfoot>
        </table>
    </body>
</html>