<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 13/05/15
  Time: 11:56 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="reportesReformaSolicitud"/>
        <title>
            ${reforma.tituloSolicitud}
        </title>
    </head>

    <body>
        <g:render template="/reportesReformaTemplates/solicitud"
                  model="[reforma: reforma, det: det, tipo: 't', unidades: unidades]"/>
    </body>
</html>