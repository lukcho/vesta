<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/06/15
  Time: 10:55 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Reportes Varios</title>
    </head>

    <body>

        <div class="row">
            <div class="col-md-8">

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Reportes</h3>
                    </div>
                </div>

                <div class="panel-body">
                    <ul class="fa-ul">
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="proformaEgresos">
                                1. Proforma de egresos no permanentes
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="egresos">
                                1.1. Proforma de egresos no permanentes - Grupo de gastos
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="recursos">
                                1.2. Proforma presupuestaria de recursos no permanentes - Grupo de gastos
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="subproyectos">
                                1.3. Proforma presupuestaria de recursos no permanentes - Subproyectos
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="poa">
                                2. Planificación operativa anual - POA
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="poaSiguiente">
                                2.a. Planificación operativa anual - POA ${new Date().format('yyyy').toInteger() + 1}
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="poaGrupoGasto">
                                2.1. POA: resumen por grupo de gasto
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="poaUnidadEjecutora">
                                2.2. POA: resumen por Área de gestión
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="poaProyecto">
                                2.3. POA: resumen por proyecto
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="poaFuente">
                                2.4. POA: resumen por fuente de financiamiento
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="disponibilidadFuente">
                                3. Disponibilidad de recursos - Por fuente de financiamiento
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="programacion">
                                4. Programación plurianual
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="avales">
                                5. Reporte Avales
                            </a>
                        </li>
                        <li>
                            <i class="fa-li fa fa-print text-info"></i>
                            <a href="#" id="reformas">
                                6. Reporte de reformas y ajustes
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <script type="text/javascript">

            function dialogXlsPdfFuente(title, urlExcel, urlPdf, pdfFileName) {
                var buttons = {};
                if (urlPdf) {
                    buttons.pdf = {
                        id        : "btnPdf",
                        label     : "<i class='fa fa-file-pdf-o'></i> Reporte Pdf",
                        className : "btn-success",
                        callback  : function () {
                            var fnt = $("#fuente").val();
                            var url = urlPdf + "?fnt=" + fnt;
                            location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=" + pdfFileName;
                        } //callback
                    };
                }
                if (urlExcel) {
                    buttons.excel = {
                        id        : "btnExcel",
                        label     : "<i class='fa fa-file-excel-o'></i> Reporte Excel",
                        className : "btn-success",
                        callback  : function () {
                            var fnt = $("#fuente").val();
                            location.href = urlExcel + "?fnt=" + fnt;
                            return false;
                        } //callback
                    };
                }
                buttons.cancelar = {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                };
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'reportesNuevos', action:'form_avales_ajax')}",
                    data    : '',
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgAvales",
                            title   : title ? title : "Reporte",
                            message : msg,
                            buttons : buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            }

            function dialogXlsPdfFuenteFechas(title, urlExcel, urlPdf, pdfFileName) {
                var buttons = {};
                if (urlPdf) {
                    buttons.pdf = {
                        id        : "btnPdf",
                        label     : "<i class='fa fa-file-pdf-o'></i> Reporte Pdf",
                        className : "btn-success",
                        callback  : function () {
                            var fnt = $("#fuente").val();
                            var url = urlPdf + "?fnt=" + fnt + "Wini=" + $("#fchaInicio").val() + "Wfin=" + $("#fchaFin").val();
                            if(!$("#fchaInicio").val() || !$("#fchaFin").val()){
                                bootbox.alert("Ingrese las fechas para realizar la búsqueda!");
                                return false;
                            }else{
                                if($("#fchaInicio").val() > $("#fchaFin").val()){
                                    bootbox.alert("La fecha de inicio debe ser menor a la fecha de fin!");

                                }else{
                                    location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "Wfilename=" + pdfFileName;
                                }

                            }
                        } //callback
                    };
                }
                if (urlExcel) {
                    buttons.excel = {
                        id        : "btnExcel",
                        label     : "<i class='fa fa-file-excel-o'></i> Reporte Excel",
                        className : "btn-success",
                        callback  : function () {
                            var fnt = $("#fuente").val();
                            var url2 = urlExcel + "?fnt=" + fnt + "&ini=" + $("#fchaInicio").val() + "&fin=" + $("#fchaFin").val();

                            if(!$("#fchaInicio").val() || !$("#fchaFin").val()){
                                bootbox.alert("Ingrese las fechas para realizar la búsqueda!");
                                return false;
                            }else{
                                location.href = url2;
                            }
//                            return false;
                        } //callback
                    };
                }
                buttons.cancelar = {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                };
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'reportesNuevos', action:'fuente_y_fechas_ajax')}",
                    data    : '',
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgAvales",
                            title   : title ? title : "Reporte",
                            message : msg,
                            buttons : buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            }

            function dialogXlsPdf(title, message, urlExcel, urlPdf, pdfFileName) {
                var buttons = {};
                if (urlPdf) {
                    buttons.pdf = {
                        id        : "btnPdf",
                        label     : "<i class='fa fa-file-pdf-o'></i> Reporte Pdf",
                        className : "btn-success",
                        callback  : function () {
                            location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + urlPdf + "&filename=" + pdfFileName;
                        } //callback
                    };
                }
                if (urlExcel) {
                    buttons.excel = {
                        id        : "btnExcel",
                        label     : "<i class='fa fa-file-excel-o'></i> Reporte Excel",
                        className : "btn-success",
                        callback  : function () {
                            location.href = urlExcel;
//                            return false;
                        } //callback
                    };
                }
                buttons.cancelar = {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                };
                bootbox.dialog({
                    id      : "dlgEgresos1",
                    title   : title ? title : "Reporte",
                    message : message ? message : "Reporte",
                    buttons : buttons
                }); //dialog
            }




            function dialogFechas(title, urlExcel, urlPdf, pdfFileName) {
                var buttons = {};
                if (urlPdf) {
                    buttons.pdf = {
                        id        : "btnPdf",
                        label     : "<i class='fa fa-file-pdf-o'></i> Reporte Pdf",
                        className : "btn-success",
                        callback  : function () {
                            var fnt = $("#fuente").val();
                            var url = urlPdf + "?fnt=" + fnt + "Wini=" + $("#fchaInicio").val() + "Wfin=" + $("#fchaFin").val();
                            if(!$("#fchaInicio").val() || !$("#fchaFin").val()){
                                bootbox.alert("Ingrese las fechas para realizar la búsqueda!");
                                return false;
                            }else{
                                if($("#fchaInicio").val() > $("#fchaFin").val()){
                                    bootbox.alert("La fecha de inicio debe ser menor a la fecha de fin!");

                                }else{
                                    location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "Wfilename=" + pdfFileName;
                                }

                            }
                        } //callback
                    };
                }
                if (urlExcel) {
                    buttons.excel = {
                        id        : "btnExcel",
                        label     : "<i class='fa fa-file-excel-o'></i> Reporte Excel",
                        className : "btn-success",
                        callback  : function () {
                            var url = urlExcel + "?ini=" + $("#fchaInicio").val() + "&fin=" + $("#fchaFin").val() + "&fuente=" + $("#fuente").val();



                            if(!$("#fchaInicio").val() || !$("#fchaFin").val()){
                                bootbox.alert("Ingrese las fechas para realizar la búsqueda!");
                                return false;
                            }else{
                                if($("#fchaInicio").val() > $("#fchaFin").val()){
                                    bootbox.alert("La fecha de inicio debe ser menor a la fecha de fin!");

                                }else{
                                    location.href = url
                                }

                            }



                        } //callback
                    };
                }
                buttons.cancelar = {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                };
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller:'reportesNuevos', action:'fuente_y_fechas_ajax')}",
                    data    : '',
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgAvales",
                            title   : title ? title : "Reporte",
                            message : msg,
                            buttons : buttons
                        }); //dialog
                        setTimeout(function () {
                            b.find(".form-control").first().focus()
                        }, 500);
                    } //success
                }); //ajax
            }






            $(function () {


                $("#avales").click(function () {
                    var urlExcel = "${createLink(controller: 'reportesNuevos', action: 'reporteAvalesExcel')}";
                    var urlPdf = "${g.createLink(controller: 'reportesNuevos',action: 'reportePdfAvales')}";
                    var pdfFileName = "";
                    dialogFechas("Reporte de Avales", urlExcel, urlPdf, pdfFileName);
                });



                $("#egresos").click(function () {
                    var urlExcel = "${createLink(controller: 'reportesNuevos', action: 'reporteEgresosGastosExcel')}";
                    var urlPdf = "${createLink(controller: 'reportesNuevos', action: 'reporteEgresosGastosPdf')}";
                    var pdfFileName = "filename=egresos_gastos.pdf";
                    dialogXlsPdf("Reporte de egresos", "Reporte de Egresos permanentes - grupo de gastos", urlExcel, urlPdf, pdfFileName);
                });

                %{--$("#avales").click(function () {--}%
                    %{--var urlExcel = "${createLink(controller: 'reportesNuevos', action: 'reporteAvalesExcel')}";--}%
                    %{--var urlPdf = "${g.createLink(controller: 'reportesNuevos',action: 'reportePdfAvales')}";--}%
                    %{--var pdfFileName = "avales.pdf";--}%
                    %{--dialogXlsPdf("Reporte de Avales", "Reporte de Avales", urlExcel, urlPdf, pdfFileName);--}%
%{--//                    dialogXlsPdfFuente("Reporte de Avales", urlExcel, urlPdf, pdfFileName);--}%
                %{--});--}%

                $("#reformas").click(function () {
                    var urlExcel = "${createLink(controller: 'reportesNuevos', action: 'reporteReformasExcel')}";
                    var urlPdf = "${createLink(controller: 'reportes5', action: 'reporteReformasPdf')}";
                    var pdfFileName = "";
                    dialogXlsPdfFuenteFechas("Reporte de Reformas y Ajustes", urlExcel, urlPdf, pdfFileName);
                });

                $("#subproyectos").click(function () {
                    var urlExcel = "${createLink(controller: 'reportes5', action: 'reporteRecursosSubproyectosExcel')}";
                    var urlPdf = "${createLink(controller: 'reportes5', action: 'reporteRecursosSubproyectosPdf')}";
                    var pdfFileName = "";
                    dialogXlsPdf("Proforma presupuestaria de recursos no permanentes - subproyectos", "Proforma presupuestaria de recursos no permanentes - subproyectos", urlExcel, urlPdf, pdfFileName);
                });

                $("#poaGrupoGasto").click(function () {
                    var urlExcel = "${createLink(controller: 'reportesNuevosExcel', action: 'poaGrupoGastoXls')}";
                    var urlPdf = "${createLink(controller: 'reportesNuevos', action: 'poaGrupoGastoPdf')}";
                    var pdfFileName = "POA_grupo_gasto.pdf";
                    dialogXlsPdfFuente("Reporte POA por grupo de gasto", urlExcel, urlPdf, pdfFileName);
                });

                $("#poaUnidadEjecutora").click(function () {
                    var urlExcel = "${createLink(controller: 'reportesNuevosExcel', action: 'poaAreaGestionXls')}";
                    var urlPdf = "${createLink(controller: 'reportesNuevos', action: 'poaAreaGestionPdf')}";
                    var pdfFileName = "POA_unidad_ejecutora.pdf";
                    dialogXlsPdf("Reporte POA por Área de gestión", "Reporte POA por Área de gestión", urlExcel, urlPdf, pdfFileName);
                });

                $("#poaProyecto").click(function () {
                    var urlExcel = "${createLink(controller: 'reportesNuevosExcel', action: 'poaProyectoXls')}";
                    var urlPdf = "${createLink(controller: 'reportesNuevos', action: 'poaProyectoPdf')}";
                    var pdfFileName = "POA_proyecto.pdf";
                    dialogXlsPdf("Reporte POA por proyecto", "Reporte POA por proyecto", urlExcel, urlPdf, pdfFileName);
                });

                $("#poaFuente").click(function () {
                    var urlExcel = "${createLink(controller: 'reportesNuevosExcel', action: 'poaFuenteXls')}";
                    var urlPdf = "${createLink(controller: 'reportesNuevos', action: 'poaFuentePdf')}";
                    var pdfFileName = "POA_fuente.pdf";
                    dialogXlsPdf("Reporte POA por fuente de financiamiento", "Reporte POA por fuente de financiamiento", urlExcel, urlPdf, pdfFileName);
                });

                $("#recursos").click(function () {
                    var urlExcel = "${createLink(controller: 'reportes5', action: 'reporteRecursosExcel')}";
                    var urlPdf = "${createLink(controller: 'reportes5', action: 'reporteRecursosPdf')}";
                    var pdfFileName = "recursos_noPermanentes.pdf";
                    dialogXlsPdf("Proforma presupuestaria de recursos no permanentes", "Proforma presupuestaria de recursos no permanentes", urlExcel, urlPdf, pdfFileName);
                });

                $("#proformaEgresos").click(function () {
                    var urlExcel = "${createLink(controller: 'reportes4', action: 'proformaEgresosNoPermanentesXlsx')}";
                    var urlPdf = null;
                    var pdfFileName = null;
                    dialogXlsPdfFuente("Reporte proforma de egresos no permanentes", urlExcel, urlPdf, pdfFileName);
                });

                $("#poa").click(function () {
                    var urlExcel = "${createLink(controller: 'reportes4', action: 'poaXlsx')}";
                    var urlPdf = null;
                    var pdfFileName = null;
                    dialogXlsPdf("Reporte Planificación Operativa Anual", "Reporte Planificación Operativa Anual", urlExcel, urlPdf, pdfFileName);
                });


                $("#poaSiguiente").click(function () {
                    var urlExcel = "${createLink(controller: 'reportes4', action: 'poaSiguienteXlsx')}";
                    var urlPdf = null;
                    var pdfFileName = null;
                    dialogXlsPdf("Reporte Planificación Operativa Anual", "Reporte Planificación Operativa Anual", urlExcel, urlPdf, pdfFileName);
                });

                $("#programacion").click(function () {
                    var urlExcel = "${createLink(controller: 'reportes4', action: 'programacionPlurianualXlsx')}";
                    var urlPdf = null;
                    var pdfFileName = null;
                    dialogXlsPdfFuente("Reporte Programación plurianual", urlExcel, urlPdf, pdfFileName);
                });

                $("#disponibilidadFuente").click(function () {
                    var urlExcel = "${createLink(controller: 'reportes6', action: 'disponibilidadFuenteXlsx')}";
                    var urlPdf = "${createLink(controller: 'reportes6', action:'disponibilidadFuentePdf')}";
                    var pdfFileName = "disponibilidad_recursos.pdf";
                    dialogXlsPdfFuente("Reporte Disponibilidad de recursos", urlExcel, urlPdf, pdfFileName);
                });

            });
        </script>

    </body>
</html>