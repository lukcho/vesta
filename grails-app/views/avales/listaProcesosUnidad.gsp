<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/01/15
  Time: 03:06 PM
--%>

<%@ page import="vesta.parametros.TipoElemento" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Lista de Procesos</title>
</head>
<body>

<div class="fila">
    <a href="#" class="btn btn-default btnCrear">
        <i class="fa fa-file-o"></i>  Crear nuevo Proceso de contratación
    </a>
</div>
<table class="table table-condensed table-bordered table-striped table-hover" style="margin-top: 25px">
    <thead>
    <tr>
        <th>Proyecto</th>
        <th>Nombre</th>
        <th>Inicio</th>
        <th>Fin</th>
        <th>Monto</th>
        %{--<th></th>--}%
        %{--<th></th>--}%
    </tr>
    </thead>
    <tbody>
    <g:each in="${procesos}" var="p">
        <tr>
            <td>${p.proyecto}</td>
            <td>${p.nombre}</td>
            <td style="text-align: center">${p.fechaInicio?.format("dd-MM-yyyy")}</td>
            <td style="text-align: center">${p.fechaFin?.format("dd-MM-yyyy")}</td>
            <td style="text-align: right">
                <g:formatNumber number="${p.getMonto()}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
            </td>
            %{--<td style="text-align: center">--}%
                %{--<a href="${g.createLink(action: 'crearProceso',id: p.id)}" class="btn">Editar</a>--}%
            %{--</td>--}%
            %{--<td style="text-align: center">--}%
                %{--<a href="${g.createLink(action: 'avalesProceso',id: p.id)}" class="btn">Avales</a>--}%
            %{--</td>--}%
        </tr>
    </g:each>

    </tbody>
</table>
<script>
    function createContextMenu (node) {
        var $tr = $(node);
        var idPro = $tr.data("id")

        var items = {
            header   : {
                label  : "Acciones",
                header : true
            },
            editar      : {
                label  : "Editar",
                icon   : "fa fa-pencil",
                action : function ($element) {
                    var id = $element.data("id");
                    createEditRow(idPro)
                }
            }
        };

        items.avales = {
            label  : "Avales",
            icon   : "fa fa-share-alt",
            action : function ($element) {
                var id = $element.data("id");
                createEditRow(id);
            }
        };

        return items
    }

    $("tbody>tr").contextMenu({
        items  : createContextMenu,
        onShow : function ($element) {
            $element.addClass("success");
        },
        onHide : function ($element) {
            $(".success").removeClass("success");
        }
    });

    $(".btnCrear").click(function() {
        createEditRow();
        return false;
    });

    function submitForm() {
        var $form = $("#frmSolicitud");
        var $btn = $("#dlgCreateEdit").find("#btnSave");

        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Guardando Solicitud");
            var formData = new FormData($form[0]);
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data        : formData,
                async       : false,
                cache       : false,
                contentType : false,
                processData : false,
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function() {
                        if (parts[0] == "SUCCESS") {
                            location.reload(true);
                        } else {
                            spinner.replaceWith($btn);
                            return false;
                        }
                    }, 1000);
                }
            });
        } else {
            //error
            $('.modal-contenido').animate({
                scrollTop: $($(".has-error")[0]).offset().top-100
            }, 1000);
            return false;
        } //else
    }

    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        console.log("idf " + data)
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'crearProceso_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Proceso",

                    class   : "modal-lg",

                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit




</script>

</body>
</html>