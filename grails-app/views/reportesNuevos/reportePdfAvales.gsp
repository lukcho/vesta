<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/06/15
  Time: 11:03 AM
--%>

<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 9/16/11
  Time: 11:35 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="vesta.avales.ProcesoAsignacion" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Aval</title>

    <rep:estilos orientacion="p" pagTitle="Reporte de Avales"/>

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
<div class="hoja">
    <rep:headerFooter title="Reporte de Avales" estilo="right"/>

    <div style="text-align: justify;float: left;font-size: 10pt;">

        <p>
            Fecha del reporte: ${new java.util.Date().format("dd-MM-yyyy HH:mm")}
        </p>

        %{--<div class="tabla" style="margin-top: 10px">--}%

    <table class="table table-bordered table-hover table-condensed table-bordered">

        <thead>
        <tr>
                    <th style="width: 100px">
                        N° AVAL
                    </th>

                    <th>
                        FUENTE
                    </th>

                    <th>
                        FECHA EMISIÓN AVAL
                    </th>

                    <th>
                       NOMBRE DEL PROCESO
                    </th>

                    <th>
                       VALOR
                    </th>

                    <th>
                        RESPONSABLE
                    </th>
        </tr>
        </thead>
        <tbody>
                <g:each in="${cn}" var="d">
                    <tr>
                        <td>${d.avalnmro}</td>
                        <td>${vesta.parametros.poaPac.Fuente.get(d.fnte__id).codigo}</td>
                        <td>${d.avalfcap}</td>
                        <td>${d.prconmbr}</td>
                        <td><g:formatNumber number="${d.sum ?: 0}" type="currency"/></td>
                        <td>${d.unejnmbr}</td>
                    </tr>
                </g:each>
        </tbody>
    </table>
    </div>
</div>

</body>
</html>